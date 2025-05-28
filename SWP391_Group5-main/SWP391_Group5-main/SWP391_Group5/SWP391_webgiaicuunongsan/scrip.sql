-- Kiểm tra và tạo cơ sở dữ liệu
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'AgriRescue_DB')
BEGIN
    CREATE DATABASE AgriRescue_DB
END
GO

-- Sử dụng cơ sở dữ liệu
USE AgriRescue_DB
GO

-- Tạo bảng users (Quản lý người dùng)
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone NVARCHAR(20) NOT NULL,
    role NVARCHAR(20) CHECK (role IN ('farmer', 'buyer', 'admin')) DEFAULT 'buyer',
    created_at DATETIME DEFAULT GETDATE()
)
GO
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = N'document_path' AND object_id = OBJECT_ID(N'users'))
BEGIN
    ALTER TABLE users
    ADD document_path NVARCHAR(255) NULL
END
GO

-- Tạo bảng products (Quản lý sản phẩm nông nghiệp)
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(500),
    price DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    language NVARCHAR(10) CHECK (language IN ('vi', 'en')) DEFAULT 'vi',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
)
GO

-- Tạo bảng campaigns (Quản lý chiến dịch cứu trợ)
CREATE TABLE campaigns (
    campaign_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    title NVARCHAR(100) NOT NULL,
    description NVARCHAR(500),
    goal_amount DECIMAL(15, 2) NOT NULL,
    current_amount DECIMAL(15, 2) DEFAULT 0,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    language NVARCHAR(10) CHECK (language IN ('vi', 'en')) DEFAULT 'vi',
    status NVARCHAR(20) CHECK (status IN ('active', 'completed', 'cancelled')) DEFAULT 'active',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
)
GO
ALTER TABLE campaigns ADD admin_status VARCHAR(20) DEFAULT 'pending';

-- Tạo bảng campaign_analytics (Theo dõi hiệu suất chiến dịch)
CREATE TABLE campaign_analytics (
    analytics_id INT IDENTITY(1,1) PRIMARY KEY,
    campaign_id INT NOT NULL,
    view_count INT DEFAULT 0,
    donation_count INT DEFAULT 0,
    total_donated DECIMAL(15, 2) DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id) ON DELETE CASCADE
)
GO

-- Tạo bảng orders (Quản lý đơn hàng)
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) CHECK (status IN ('pending', 'completed', 'cancelled')) DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
)
GO

-- Tạo bảng messages (Hỗ trợ giao tiếp giữa người dùng)
CREATE TABLE messages (
    message_id INT IDENTITY(1,1) PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content NVARCHAR(1000) NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    language NVARCHAR(10) CHECK (language IN ('vi', 'en')) DEFAULT 'vi',
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id)
)
GO

-- Tạo bảng content_moderation (Quản lý kiểm duyệt nội dung)
CREATE TABLE content_moderation (
    moderation_id INT IDENTITY(1,1) PRIMARY KEY,
    content_id INT NOT NULL,
    content_type NVARCHAR(50) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('pending', 'approved', 'rejected')) DEFAULT 'pending',
    moderator_id INT NOT NULL,
    moderated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (moderator_id) REFERENCES users(user_id) ON DELETE CASCADE
)
GO

-- Tạo bảng system_settings (Quản lý cấu hình hệ thống)
CREATE TABLE system_settings (
    setting_id INT IDENTITY(1,1) PRIMARY KEY,
    setting_key NVARCHAR(50) NOT NULL UNIQUE,
    setting_value NVARCHAR(255) NOT NULL,
    description NVARCHAR(500),
    updated_at DATETIME DEFAULT GETDATE()
)
GO

-- Thêm dữ liệu mẫu vào bảng users
INSERT INTO users (username, password, name, email, phone, role) VALUES
(N'nguyenvana', HASHBYTES('MD5', 'password123'), N'Nguyen Van A', N'a@example.com', N'+84987654321', N'farmer'),
(N'tranthib', HASHBYTES('MD5', 'password456'), N'Tran Thi B', N'b@example.com', N'+84912345678', N'buyer'),
(N'admin1', HASHBYTES('MD5', 'admin123'), N'Admin User', N'admin@example.com', N'+84911122333', N'admin')
GO

-- Thêm dữ liệu mẫu vào bảng products
INSERT INTO products (user_id, name, description, price, quantity, language) VALUES
(1, N'Gạo ST25', N'Gạo chất lượng cao từ Đồng Tháp', 15000, 100, N'vi'),
(1, N'ST25 Rice', N'High-quality rice from Dong Thap', 15000, 100, N'en')
GO

-- Thêm dữ liệu mẫu vào bảng campaigns
INSERT INTO campaigns (user_id, title, description, goal_amount, start_date, end_date, language) VALUES
(1, N'Hỗ trợ nông dân Đồng Tháp', N'Giúp đỡ nông dân bị ảnh hưởng lũ lụt', 50000000, '2025-05-01', '2025-06-01', N'vi'),
(1, N'Support Dong Thap Farmers', N'Help farmers affected by floods', 50000000, '2025-05-01', '2025-06-01', N'en')
GO

-- Kiểm tra dữ liệu
SELECT * FROM users
SELECT * FROM products
SELECT * FROM campaigns
GO

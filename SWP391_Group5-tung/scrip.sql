

-- Tạo lại DB
CREATE DATABASE AgriRescue;
GO

-- Sử dụng DB
USE AgriRescue;
GO

-- Bảng người dùng
CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone NVARCHAR(20) NOT NULL,
    role NVARCHAR(20) CHECK (role IN ('farmer', 'buyer', 'admin')) DEFAULT 'buyer',
    created_at DATETIME DEFAULT GETDATE()
);
GO

-- Bảng sản phẩm
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
);
GO

-- Bảng chiến dịch
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
);
GO

-- Phân tích hiệu suất chiến dịch
CREATE TABLE campaign_analytics (
    analytics_id INT IDENTITY(1,1) PRIMARY KEY,
    campaign_id INT NOT NULL,
    view_count INT DEFAULT 0,
    donation_count INT DEFAULT 0,
    total_donated DECIMAL(15, 2) DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id) ON DELETE CASCADE
);
GO

-- Đơn hàng
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    status NVARCHAR(20) CHECK (status IN ('pending', 'completed', 'cancelled')) DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE NO ACTION,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
GO

-- Tin nhắn giữa người dùng
CREATE TABLE messages (
    message_id INT IDENTITY(1,1) PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    content NVARCHAR(1000) NOT NULL,
    sent_at DATETIME DEFAULT GETDATE(),
    language NVARCHAR(10) CHECK (language IN ('vi', 'en')) DEFAULT 'vi',
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE NO ACTION,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE NO ACTION
);

GO

-- Kiểm duyệt nội dung
CREATE TABLE content_moderation (
    moderation_id INT IDENTITY(1,1) PRIMARY KEY,
    content_id INT NOT NULL,
    content_type NVARCHAR(50) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('pending', 'approved', 'rejected')) DEFAULT 'pending',
    moderator_id INT NOT NULL,
    moderated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (moderator_id) REFERENCES users(user_id) ON DELETE CASCADE
);
GO

-- Cài đặt hệ thống
CREATE TABLE system_settings (
    setting_id INT IDENTITY(1,1) PRIMARY KEY,
    setting_key NVARCHAR(50) NOT NULL UNIQUE,
    setting_value NVARCHAR(255) NOT NULL,
    description NVARCHAR(500),
    updated_at DATETIME DEFAULT GETDATE()
);
GO

-- Thêm dữ liệu mẫu
INSERT INTO users (username, password, name, email, phone, role) VALUES
(N'nguyenvana', N'password123', N'Nguyen Van A', N'a@example.com', N'+84987654321', N'farmer'),
(N'tranthib', N'password456', N'Tran Thi B', N'b@example.com', N'+84912345678', N'buyer'),
(N'admin1', N'admin123', N'Admin User', N'admin@example.com', N'+84911122333', N'admin');
GO

INSERT INTO campaigns (user_id, title, description, goal_amount, current_amount, start_date, end_date, language, status, created_at)
VALUES
(1, N'Hỗ trợ nông dân Đồng Tháp', N'Giúp đỡ nông dân bị ảnh hưởng lũ lụt', 50000000, 20000000, '2025-05-01', '2025-06-01', 'vi', 'active', GETDATE()),
(1, N'Support Dong Thap Farmers', N'Help farmers affected by floods', 50000000, 20000000, '2025-05-01', '2025-06-01', 'en', 'active', GETDATE()),
(1, N'Cứu trợ mùa màng Long An', N'Hỗ trợ nông dân sau bão', 30000000, 30000000, '2025-04-01', '2025-04-30', 'vi', 'completed', GETDATE()),
(1, N'Long An Crop Relief', N'Support farmers after storm', 30000000, 30000000, '2025-04-01', '2025-04-30', 'en', 'completed', GETDATE()),
(1, N'Hỗ trợ giống cây trồng Tiền Giang', N'Cung cấp giống mới cho nông dân', 40000000, 10000000, '2025-03-01', '2025-03-15', 'vi', 'cancelled', GETDATE()),
(1, N'Tien Giang Seed Support', N'Provide new seeds for farmers', 40000000, 10000000, '2025-03-01', '2025-03-15', 'en', 'cancelled', GETDATE());
GO

Select *from users
Select *from campaigns



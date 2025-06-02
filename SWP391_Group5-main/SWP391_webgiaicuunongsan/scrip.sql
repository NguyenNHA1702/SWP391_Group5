
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'AgriRescue_DB')
BEGIN
    CREATE DATABASE AgriRescue_DB
END
GO

-- Sử dụng cơ sở dữ liệu
USE AgriRescue_DB
GO

-- Tạo bảng users (Quản lý người dùng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'users')
BEGIN
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
END
GO
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = N'document_path' AND object_id = OBJECT_ID(N'users'))
BEGIN
    ALTER TABLE users
    ADD document_path NVARCHAR(255) NULL
END
GO

-- Tạo bảng products (Quản lý sản phẩm nông nghiệp)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'products')
BEGIN
    CREATE TABLE products (
        product_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        name NVARCHAR(100) NOT NULL,
        description NVARCHAR(500) NULL,
        price DECIMAL(10, 2) NOT NULL,
        quantity INT NOT NULL,
        language NVARCHAR(10) CHECK (language IN ('vi', 'en')) DEFAULT 'vi',
        created_at DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
    )
END
GO

-- Tạo bảng campaigns (Quản lý chiến dịch cứu trợ)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'campaigns')
BEGIN
    CREATE TABLE campaigns (
        campaign_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        title NVARCHAR(100) NOT NULL,
        description NVARCHAR(500) NULL,
        goal_amount DECIMAL(15, 2) NOT NULL,
        current_amount DECIMAL(15, 2) DEFAULT 0,
        start_date DATETIME NOT NULL,
        end_date DATETIME NOT NULL,
        language NVARCHAR(10) CHECK (language IN ('vi', 'en')) DEFAULT 'vi',
        status NVARCHAR(20) CHECK (status IN ('news', 'active', 'completed', 'cancelled')) DEFAULT 'news',
        created_at DATETIME DEFAULT GETDATE(),
        admin_status NVARCHAR(20) CHECK (admin_status IN ('pending', 'accepted', 'rejected')) DEFAULT 'pending',
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
    )
END
GO


-- Tạo bảng campaign_analytics (Theo dõi hiệu suất chiến dịch)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'campaign_analytics')
BEGIN
    CREATE TABLE campaign_analytics (
        analytics_id INT IDENTITY(1,1) PRIMARY KEY,
        campaign_id INT NOT NULL,
        view_count INT DEFAULT 0,
        donation_count INT DEFAULT 0,
        total_donated DECIMAL(15, 2) DEFAULT 0,
        created_at DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id) ON DELETE CASCADE
    )
END
GO

-- Tạo bảng orders (Quản lý đơn hàng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'orders')
BEGIN
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
END
GO

-- Tạo bảng messages (Hỗ trợ giao tiếp giữa người dùng)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'messages')
BEGIN
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
END
GO

-- Tạo bảng content_moderation (Quản lý kiểm duyệt nội dung)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'content_moderation')
BEGIN
    CREATE TABLE content_moderation (
        moderation_id INT IDENTITY(1,1) PRIMARY KEY,
        content_id INT NOT NULL,
        content_type NVARCHAR(50) NOT NULL,
        status NVARCHAR(20) CHECK (status IN ('pending', 'approved', 'rejected')) DEFAULT 'pending',
        moderator_id INT NOT NULL,
        moderated_at DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (moderator_id) REFERENCES users(user_id) ON DELETE CASCADE
    )
END
GO

-- Tạo bảng system_settings (Quản lý cấu hình hệ thống)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'system_settings')
BEGIN
    CREATE TABLE system_settings (
        setting_id INT IDENTITY(1,1) PRIMARY KEY,
        setting_key NVARCHAR(50) NOT NULL UNIQUE,
        setting_value NVARCHAR(255) NOT NULL,
        description NVARCHAR(500) NULL,
        updated_at DATETIME DEFAULT GETDATE()
    )
END
GO

CREATE TABLE join_requests (
    request_id INT IDENTITY(1,1) PRIMARY KEY,
    campaign_id INT NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20) NOT NULL,
    reason NVARCHAR(500),
    status NVARCHAR(20) CHECK (status IN ('pending', 'approved', 'rejected')) DEFAULT 'pending',
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(campaign_id) ON DELETE CASCADE
);
GO


-- Thêm dữ liệu mẫu vào bảng users
SET IDENTITY_INSERT users ON;
INSERT INTO users (user_id, username, password, name, email, phone, role) VALUES
(1, N'nguyenvana', HASHBYTES('MD5', 'password123'), N'Nguyen Van A', N'a@example.com', N'+84987654321', N'farmer'),
(2, N'tranthib', HASHBYTES('MD5', 'password456'), N'Tran Thi B', N'b@example.com', N'+84912345678', N'buyer'),
(3, N'admin1', HASHBYTES('MD5', 'admin123'), N'Admin User', N'admin@example.com', N'+84911122333', N'admin');
SET IDENTITY_INSERT users OFF;
GO

-- Thêm dữ liệu mẫu vào bảng products
SET IDENTITY_INSERT products ON;
INSERT INTO products (product_id, user_id, name, description, price, quantity, language) VALUES
(1, 1, N'Gạo ST25', N'Gạo chất lượng cao từ Đồng Tháp', 15000, 100, N'vi'),
(2, 1, N'ST25 Rice', N'High-quality rice from Dong Thap', 15000, 100, N'en'),
(3, 1, N'Gạo ST25', N'Gạo chất lượng cao từ Đong Thap', 15000.00, 100, N'vi'),
(4, 1, N'Bơ sáp Đắk Lắk', N'Bơ ngon, dẻo, từ Đắk Lắk', 35000, 60, N'vi'),
(5, 1, N'Dak Lak Avocado', N'Creamy avocado from Dak Lak', 35000, 60, N'en'),
(6, 1, N'Mít thái', N'Mít chín cây thơm ngon từ miền Tây', 25000, 50, N'vi'),
(7, 1, N'Thai Jackfruit', N'Fresh jackfruit harvested from Mekong Delta', 25000, 50, N'en'),
(8, 1, N'Dưa hấu Long An', N'Dưa hấu đỏ, ngọt, chất lượng cao', 10000, 120, N'vi'),
(9, 1, N'Long An Watermelon', N'Sweet red watermelon from Long An province', 10000, 120, N'en'),
(10, 1, N'Chuối xiêm', N'Chuối xiêm miền Tây, ngọt và mềm', 12000, 80, N'vi'),
(11, 1, N'Mekong Banana', N'Mekong bananas, sweet and soft', 12000, 80, N'en'),
(12, 1, N'Khoai lang Nhật', N'Khoai lang ngọt thơm, giống Nhật', 18000, 70, N'vi'),
(13, 1, N'Japanese Sweet Potato', N'Sweet potato variety from Japan', 18000, 70, N'en');

SET IDENTITY_INSERT products OFF;
GO




-- Thêm dữ liệu mẫu vào bảng campaigns
SET IDENTITY_INSERT campaigns ON;
INSERT INTO campaigns (campaign_id, user_id, title, description, goal_amount, current_amount, start_date, end_date, language, status, created_at, admin_status) VALUES
(1, 1, N'Hỗ trợ nông dân Đồng Tháp', N'Giúp đỡ nông dân bị ảnh hưởng lũ lụt', 50000000.00, 20000.00, '2025-05-01', '2025-06-01', N'vi', N'news', '2025-05-24T19:50:21.023', N'pending'),
(2, 1, N'Support Dong Thap Farmers', N'Help farmers affected by floods', 50000000.00, 0.00, '2025-05-01', '2025-06-01', N'en', N'news', '2025-05-24T19:50:21.023', N'pending'),
(3, 1, N'Hỗ trợ tiêu thụ bơ Đắk Lắk', N'Giúp nông dân bán bơ sáp', 30000000, 0, '2025-06-01', '2025-06-20', N'vi', N'news', GETDATE(), N'pending'),
(4, 1, N'Support Dak Lak Avocados', N'Help farmers sell avocado surplus', 30000000, 0, '2025-06-01', '2025-06-20', N'en', N'news', GETDATE(), N'pending'),
(5, 1, N'Giải cứu mít thái miền Tây', N'Hỗ trợ bán mít thái chín cây', 35000000, 0, '2025-06-02', '2025-06-22', N'vi', N'news', GETDATE(), N'pending'),
(6, 1, N'Rescue Thai Jackfruit', N'Support Thai jackfruit farmers', 35000000, 0, '2025-06-02', '2025-06-22', N'en', N'news', GETDATE(), N'pending'),
(7, 1, N'Giải cứu dưa hấu Long An', N'Dưa hấu đang tồn kho, cần giải cứu', 40000000, 0, '2025-06-03', '2025-06-25', N'vi', N'news', GETDATE(), N'pending'),
(8, 1, N'Save Long An Watermelons', N'Watermelon rescue campaign', 40000000, 0, '2025-06-03', '2025-06-25', N'en', N'news', GETDATE(), N'pending'),
(9, 1, N'Ủng hộ nông dân trồng chuối', N'Tiêu thụ chuối xiêm số lượng lớn', 20000000, 0, '2025-06-04', '2025-06-18', N'vi', N'news', GETDATE(), N'pending'),
(10, 1, N'Support Banana Growers', N'Rescue banana stocks from Mekong', 20000000, 0, '2025-06-04', '2025-06-18', N'en', N'news', GETDATE(), N'pending'),
(11, 1, N'Tiêu thụ khoai lang Nhật', N'Giải cứu khoai lang Nhật từ Vĩnh Long', 25000000, 0, '2025-06-05', '2025-06-20', N'vi', N'news', GETDATE(), N'pending'),
(12, 1, N'Sell Japanese Sweet Potatoes', N'Promote sweet potatoes from Vinh Long', 25000000, 0, '2025-06-05', '2025-06-20', N'en', N'news', GETDATE(), N'pending');
SET IDENTITY_INSERT campaigns OFF;
GO





SET ANSI_PADDING ON
GO

ALTER TABLE [dbo].[system_settings] ADD UNIQUE NONCLUSTERED 
(
	[setting_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO

ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO

ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[campaign_analytics] ADD  DEFAULT ((0)) FOR [view_count]
GO
ALTER TABLE [dbo].[campaign_analytics] ADD  DEFAULT ((0)) FOR [donation_count]
GO
ALTER TABLE [dbo].[campaign_analytics] ADD  DEFAULT ((0)) FOR [total_donated]
GO
ALTER TABLE [dbo].[campaign_analytics] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[campaigns] ADD  DEFAULT ((0)) FOR [current_amount]
GO
ALTER TABLE [dbo].[campaigns] ADD  DEFAULT ('vi') FOR [language]
GO
ALTER TABLE [dbo].[campaigns] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[campaigns] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[campaigns] ADD  DEFAULT ('pending') FOR [admin_status]
GO
ALTER TABLE [dbo].[content_moderation] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[content_moderation] ADD  DEFAULT (getdate()) FOR [moderated_at]
GO
ALTER TABLE [dbo].[messages] ADD  DEFAULT (getdate()) FOR [sent_at]
GO
ALTER TABLE [dbo].[messages] ADD  DEFAULT ('vi') FOR [language]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT ('vi') FOR [language]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[system_settings] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('buyer') FOR [role]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[campaign_analytics]  WITH CHECK ADD FOREIGN KEY([campaign_id])
REFERENCES [dbo].[campaigns] ([campaign_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[content_moderation]  WITH CHECK ADD FOREIGN KEY([moderator_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([receiver_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([sender_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([product_id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD  CONSTRAINT [CHK_campaigns_admin_status] CHECK  (([admin_status]='accepted' OR [admin_status]='rejected' OR [admin_status]='pending'))
GO
ALTER TABLE [dbo].[campaigns] CHECK CONSTRAINT [CHK_campaigns_admin_status]
GO
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD  CONSTRAINT [CHK_campaigns_status] CHECK  (([status]='cancelled' OR [status]='completed' OR [status]='active' OR [status]='news'))
GO
ALTER TABLE [dbo].[campaigns] CHECK CONSTRAINT [CHK_campaigns_status]
GO
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[content_moderation]  WITH CHECK ADD CHECK  (([status]='rejected' OR [status]='approved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD CHECK  (([status]='cancelled' OR [status]='completed' OR [status]='pending'))
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([role]='admin' OR [role]='buyer' OR [role]='farmer'))
GO

CREATE TABLE contact_requests (
    contact_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    subject NVARCHAR(100) NOT NULL,
    message NVARCHAR(500) NOT NULL,
    status NVARCHAR(20) CHECK (status IN ('pending', 'resolved')) DEFAULT 'pending',
    created_at DATETIME DEFAULT GETDATE(),
    resolved_at DATETIME NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
	)



-- Duyệt tất cả các chiến dịch test
UPDATE campaigns
SET status = 
    CASE 
        WHEN admin_status = 'accepted' THEN 'active'
        WHEN admin_status = 'rejected' THEN 'cancelled'
        ELSE 'news'
    END;
GO

CREATE OR ALTER TRIGGER trg_UpdateStatusOnAdminStatusChange
ON campaigns
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE c
    SET c.status = 
        CASE 
            WHEN i.admin_status = 'accepted' THEN 'active'
            WHEN i.admin_status = 'rejected' THEN 'cancelled'
            ELSE c.status
        END
    FROM campaigns c
    INNER JOIN inserted i ON c.campaign_id = i.campaign_id
    WHERE i.admin_status IN ('accepted', 'rejected');
END;


CREATE OR ALTER TRIGGER trg_PreventManualStatusUpdate
ON campaigns
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deleted d ON i.campaign_id = d.campaign_id
        WHERE i.status <> d.status
          AND ISNULL(i.admin_status, '') = ISNULL(d.admin_status, '')
          AND i.status <> 'completed' 
    )
    BEGIN
        RAISERROR('Cột "status" không được chỉnh sửa trực tiếp. Vui lòng cập nhật thông qua "admin_status".', 16, 1);
        ROLLBACK;
        RETURN;
    END

    UPDATE campaigns
    SET
        title = i.title,
        description = i.description,
        goal_amount = i.goal_amount,
        current_amount = i.current_amount,
        start_date = i.start_date,
        end_date = i.end_date,
        language = i.language,
        created_at = i.created_at,
        admin_status = i.admin_status,
        status = i.status
    FROM inserted i
    WHERE campaigns.campaign_id = i.campaign_id;
END;

ALTER TABLE campaigns
ADD image_url NVARCHAR(255) NULL;
SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'campaigns' AND COLUMN_NAME = 'image_url';
UPDATE campaigns
SET image_url = 'assets/images/bo-daklak.jpg'
WHERE campaign_id = 3;

UPDATE campaigns
SET image_url = 'assets/images/mit-mientay.jpg'
WHERE campaign_id = 5;







-- Kiểm tra dữ liệu
SELECT * FROM users
SELECT * FROM products
SELECT * FROM campaigns
GO
USE AgriRescue_DB;
SELECT * FROM campaigns;
-- Kiểm tra có chiến dịch nào thỏa không
SELECT * FROM campaigns
WHERE status = 'active' AND admin_status = 'accepted' AND GETDATE() BETWEEN start_date AND end_date;


SELECT * FROM join_requests;

UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 5;

UPDATE campaigns
SET admin_status = 'rejected'
WHERE campaign_id = 6;

SELECT campaign_id, title, image_url FROM campaigns

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'campaigns'

UPDATE campaigns
SET image_url = '/assets/images/bo-daklak.jpg'
WHERE campaign_id = 3;

UPDATE campaigns
SET image_url = '/assets/images/mit-mientay.jpg'
WHERE campaign_id = 5;





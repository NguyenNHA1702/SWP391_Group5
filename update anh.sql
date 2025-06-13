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


UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 1;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 2;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 3;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 4;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 5;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 6;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 10;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 11;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 12;
UPDATE campaigns
SET admin_status = 'accepted'
WHERE campaign_id = 9;


UPDATE campaigns
SET image_url = '/assets/images/dong-thap.jpg'
WHERE campaign_id = 1;

UPDATE campaigns
SET image_url = '/assets/images/dong-thap.jpg'
WHERE campaign_id = 2;
UPDATE campaigns
SET image_url = '/assets/images/dong-thap-2.jpg'
WHERE campaign_id = 3;

UPDATE campaigns
SET image_url = '/assets/images/bo-daklak.jpg'
WHERE campaign_id = 4;
UPDATE campaigns
SET image_url = '/assets/images/mit-mientay.jpg'
WHERE campaign_id = 5;

UPDATE campaigns
SET image_url = '/assets/images/dua-hau-long-an.jpg'
WHERE campaign_id = 6;
UPDATE campaigns
SET image_url = '/assets/images/dua-hau-long-an.jpg'
WHERE campaign_id = 7;

UPDATE campaigns
SET image_url = '/assets/images/mit-mientay.jpg.jpg'
WHERE campaign_id = 8;

UPDATE campaigns
SET image_url = '/assets/images/ung-ho-trong-chuoi.jpg'
WHERE campaign_id = 9;

UPDATE campaigns
SET image_url = '/assets/images/ung-ho-trong-chuoi.jpg'
WHERE campaign_id = 10;

UPDATE campaigns
SET image_url = '/assets/images/khoai-lang-nhat.jpg'
WHERE campaign_id = 11;

UPDATE campaigns
SET image_url = '/assets/images/khoai-lang-nhatv2.jpg'
WHERE campaign_id = 12;


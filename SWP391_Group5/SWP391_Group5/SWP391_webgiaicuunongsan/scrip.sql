CREATE DATABASE AgriRescue_DB
GO
USE [AgriRescue_DB]
GO
/****** Object:  Table [dbo].[campaign_analytics]    Script Date: 5/25/2025 3:57:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[campaign_analytics](
	[analytics_id] [int] IDENTITY(1,1) NOT NULL,
	[campaign_id] [int] NOT NULL,
	[view_count] [int] NULL,
	[donation_count] [int] NULL,
	[total_donated] [decimal](15, 2) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[analytics_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[campaigns]    Script Date: 5/25/2025 3:57:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[campaigns](
	[campaign_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[description] [nvarchar](500) NULL,
	[goal_amount] [decimal](15, 2) NOT NULL,
	[current_amount] [decimal](15, 2) NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[language] [nvarchar](10) NULL,
	[status] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[campaign_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[content_moderation]    Script Date: 5/25/2025 3:57:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[content_moderation](
	[moderation_id] [int] IDENTITY(1,1) NOT NULL,
	[content_id] [int] NOT NULL,
	[content_type] [nvarchar](50) NOT NULL,
	[status] [nvarchar](20) NULL,
	[moderator_id] [int] NOT NULL,
	[moderated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[moderation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messages]    Script Date: 5/25/2025 3:57:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[messages](
	[message_id] [int] IDENTITY(1,1) NOT NULL,
	[sender_id] [int] NOT NULL,
	[receiver_id] [int] NOT NULL,
	[content] [nvarchar](1000) NOT NULL,
	[sent_at] [datetime] NULL,
	[language] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[message_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 5/25/2025 3:57:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[total_price] [decimal](10, 2) NOT NULL,
	[order_date] [datetime] NULL,
	[status] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 5/25/2025 3:57:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](500) NULL,
	[price] [decimal](10, 2) NOT NULL,
	[quantity] [int] NOT NULL,
	[language] [nvarchar](10) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[system_settings]    Script Date: 5/25/2025 3:57:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[system_settings](
	[setting_id] [int] IDENTITY(1,1) NOT NULL,
	[setting_key] [nvarchar](50) NOT NULL,
	[setting_value] [nvarchar](255) NOT NULL,
	[description] [nvarchar](500) NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[setting_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 5/25/2025 3:57:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[phone] [nvarchar](20) NOT NULL,
	[role] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[campaigns] ON 

INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (1, 1, N'Hỗ trợ nông dân Đồng Tháp', N'Giúp đỡ nông dân bị ảnh hưởng lũ lụt', CAST(50000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-01T00:00:00.000' AS DateTime), CAST(N'2025-06-01T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-24T19:50:21.023' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (2, 1, N'Support Dong Thap Farmers', N'Help farmers affected by floods', CAST(50000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-01T00:00:00.000' AS DateTime), CAST(N'2025-06-01T00:00:00.000' AS DateTime), N'en', N'active', CAST(N'2025-05-24T19:50:21.023' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (10, 1, N'Hỗ trợ nông dân Đồng Tháp', N'Giúp đỡ nông dân bị ảnh hưởng lũ lụt', CAST(50000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-01T00:00:00.000' AS DateTime), CAST(N'2025-06-01T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (11, 6, N'Support Dong Thap Farmers', N'Help farmers affected by floods', CAST(50000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-01T00:00:00.000' AS DateTime), CAST(N'2025-06-01T00:00:00.000' AS DateTime), N'en', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (12, 7, N'Quỹ giúp đỡ nông dân Lâm Đồng', N'Ủng hộ nông dân trồng rau an toàn', CAST(30000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-10T00:00:00.000' AS DateTime), CAST(N'2025-06-10T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (13, 8, N'Lam Dong Farmer Support Fund', N'Support safe vegetable farmers', CAST(30000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-10T00:00:00.000' AS DateTime), CAST(N'2025-06-10T00:00:00.000' AS DateTime), N'en', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (14, 1, N'Chiến dịch chống hạn', N'Giúp đỡ nông dân chống hạn hán', CAST(40000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-15T00:00:00.000' AS DateTime), CAST(N'2025-07-15T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (15, 6, N'Drought Relief Campaign', N'Help farmers fight drought', CAST(40000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-15T00:00:00.000' AS DateTime), CAST(N'2025-07-15T00:00:00.000' AS DateTime), N'en', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (16, 7, N'Ủng hộ nông dân miền Trung', N'Hỗ trợ nông dân bị bão lũ', CAST(60000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-20T00:00:00.000' AS DateTime), CAST(N'2025-06-20T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (17, 8, N'Support Central Farmers', N'Support farmers affected by storms', CAST(60000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-20T00:00:00.000' AS DateTime), CAST(N'2025-06-20T00:00:00.000' AS DateTime), N'en', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (18, 1, N'Quỹ giúp đỡ nông dân Bắc Bộ', N'Ủng hộ nông dân phát triển nông nghiệp', CAST(35000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-25T00:00:00.000' AS DateTime), CAST(N'2025-06-25T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (19, 6, N'North Vietnam Farmer Aid Fund', N'Support agricultural development', CAST(35000000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-25T00:00:00.000' AS DateTime), CAST(N'2025-06-25T00:00:00.000' AS DateTime), N'en', N'active', CAST(N'2025-05-24T22:29:45.000' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (20, 1, N'a1', N'aa', CAST(20000.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-22T00:00:00.000' AS DateTime), CAST(N'2025-05-25T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-25T02:15:32.057' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (21, 1, N'a3', N'aaaaaa', CAST(11111.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-17T00:00:00.000' AS DateTime), CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-25T02:18:24.083' AS DateTime))
INSERT [dbo].[campaigns] ([campaign_id], [user_id], [title], [description], [goal_amount], [current_amount], [start_date], [end_date], [language], [status], [created_at]) VALUES (22, 1, N'33333333', N'333333', CAST(10100.00 AS Decimal(15, 2)), CAST(0.00 AS Decimal(15, 2)), CAST(N'2025-05-15T00:00:00.000' AS DateTime), CAST(N'2025-05-30T00:00:00.000' AS DateTime), N'vi', N'active', CAST(N'2025-05-25T03:05:39.717' AS DateTime))
SET IDENTITY_INSERT [dbo].[campaigns] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 

INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (1, 1, N'Gạo ST25', N'Gạo chất lượng cao từ Đồng Tháp', CAST(15000.00 AS Decimal(10, 2)), 100, N'vi', CAST(N'2025-05-24T19:50:11.153' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (2, 1, N'ST25 Rice', N'High-quality rice from Dong Thap', CAST(15000.00 AS Decimal(10, 2)), 100, N'en', CAST(N'2025-05-24T19:50:11.153' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (12, 1, N'Gạo ST25', N'Gạo chất lượng cao từ Đồng Tháp', CAST(15000.00 AS Decimal(10, 2)), 100, N'vi', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (13, 6, N'ST25 Rice', N'High-quality rice from Dong Thap', CAST(15000.00 AS Decimal(10, 2)), 100, N'en', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (14, 7, N'Bắp cải tươi', N'Bắp cải tươi ngon từ Lâm Đồng', CAST(12000.00 AS Decimal(10, 2)), 50, N'vi', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (15, 8, N'Fresh Cabbage', N'Fresh cabbage from Lam Dong', CAST(12000.00 AS Decimal(10, 2)), 50, N'en', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (16, 1, N'Cà chua bi', N'Cà chua bi hữu cơ sạch', CAST(18000.00 AS Decimal(10, 2)), 80, N'vi', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (17, 6, N'Organic Cherry Tomato', N'Clean organic cherry tomatoes', CAST(18000.00 AS Decimal(10, 2)), 80, N'en', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (18, 7, N'Khoai lang tím', N'Khoai lang tím giàu dinh dưỡng', CAST(14000.00 AS Decimal(10, 2)), 90, N'vi', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (19, 8, N'Purple Sweet Potato', N'Nutritious purple sweet potatoes', CAST(14000.00 AS Decimal(10, 2)), 90, N'en', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (20, 1, N'Dưa leo sạch', N'Dưa leo sạch an toàn', CAST(13000.00 AS Decimal(10, 2)), 60, N'vi', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
INSERT [dbo].[products] ([product_id], [user_id], [name], [description], [price], [quantity], [language], [created_at]) VALUES (21, 6, N'Safe Cucumber', N'Safe cucumber', CAST(13000.00 AS Decimal(10, 2)), 60, N'en', CAST(N'2025-05-24T22:29:44.987' AS DateTime))
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [username], [password], [name], [email], [phone], [role], [created_at]) VALUES (1, N'nguyenvana', N'123', N'Nguyen Van A', N'an123@gmail.com', N'+84987654321', N'farmer', CAST(N'2025-05-24T19:50:04.927' AS DateTime))
INSERT [dbo].[users] ([user_id], [username], [password], [name], [email], [phone], [role], [created_at]) VALUES (2, N'tranthib', N'456', N'Tran Thi B', N'ban123@gmail.com', N'+84912345678', N'buyer', CAST(N'2025-05-24T19:50:04.927' AS DateTime))
INSERT [dbo].[users] ([user_id], [username], [password], [name], [email], [phone], [role], [created_at]) VALUES (3, N'admin1', N'789', N'Admin User', N'admin456@gmail.com', N'+84911122333', N'admin', CAST(N'2025-05-24T19:50:04.927' AS DateTime))
INSERT [dbo].[users] ([user_id], [username], [password], [name], [email], [phone], [role], [created_at]) VALUES (4, N'buyer1', N'buyerpass1', N'Nguyễn Văn A', N'buyer1@example.com', N'0901234567', N'buyer', CAST(N'2025-05-24T22:28:45.583' AS DateTime))
INSERT [dbo].[users] ([user_id], [username], [password], [name], [email], [phone], [role], [created_at]) VALUES (5, N'buyer2', N'buyerpass2', N'Lê Thị B', N'buyer2@example.com', N'0907654321', N'buyer', CAST(N'2025-05-24T22:28:45.583' AS DateTime))
INSERT [dbo].[users] ([user_id], [username], [password], [name], [email], [phone], [role], [created_at]) VALUES (6, N'farmer1', N'farmerpass1', N'Trần Văn C', N'farmer1@example.com', N'0912345678', N'farmer', CAST(N'2025-05-24T22:28:45.583' AS DateTime))
INSERT [dbo].[users] ([user_id], [username], [password], [name], [email], [phone], [role], [created_at]) VALUES (7, N'farmer2', N'farmerpass2', N'Phạm Thị D', N'farmer2@example.com', N'0918765432', N'farmer', CAST(N'2025-05-24T22:28:45.583' AS DateTime))
INSERT [dbo].[users] ([user_id], [username], [password], [name], [email], [phone], [role], [created_at]) VALUES (8, N'farmer3', N'farmerpass3', N'Đỗ Văn E', N'farmer3@example.com', N'0923456789', N'farmer', CAST(N'2025-05-24T22:28:45.583' AS DateTime))
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__system_s__0DFAC427973B4CE4]    Script Date: 5/25/2025 3:57:37 AM ******/
ALTER TABLE [dbo].[system_settings] ADD UNIQUE NONCLUSTERED 
(
	[setting_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E61643DC520F5]    Script Date: 5/25/2025 3:57:37 AM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__F3DBC5723661B0DD]    Script Date: 5/25/2025 3:57:37 AM ******/
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
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD CHECK  (([status]='cancelled' OR [status]='completed' OR [status]='active'))
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

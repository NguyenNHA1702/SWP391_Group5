CREATE DATABASE AgriRescue_DB
USE [AgriRescue_DB]
GO
/****** Object:  Table [dbo].[campaign_analytics]    Script Date: 10/06/2025 22:00:08 ******/
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
/****** Object:  Table [dbo].[campaigns]    Script Date: 10/06/2025 22:00:08 ******/
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
	[admin_status] [nvarchar](20) NULL,
	[image_url] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[campaign_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[contact_requests]    Script Date: 10/06/2025 22:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contact_requests](
	[contact_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[subject] [nvarchar](100) NOT NULL,
	[message] [nvarchar](500) NOT NULL,
	[status] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
	[resolved_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[content_moderation]    Script Date: 10/06/2025 22:00:08 ******/
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
/****** Object:  Table [dbo].[join_requests]    Script Date: 10/06/2025 22:00:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[join_requests](
	[request_id] [int] IDENTITY(1,1) NOT NULL,
	[campaign_id] [int] NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[email] [nvarchar](100) NOT NULL,
	[phone] [nvarchar](20) NOT NULL,
	[reason] [nvarchar](500) NULL,
	[status] [nvarchar](20) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[messages]    Script Date: 10/06/2025 22:00:08 ******/
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
/****** Object:  Table [dbo].[orders]    Script Date: 10/06/2025 22:00:08 ******/
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
/****** Object:  Table [dbo].[products]    Script Date: 10/06/2025 22:00:08 ******/
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
	[campaign_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[system_settings]    Script Date: 10/06/2025 22:00:08 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[setting_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[setting_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[setting_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 10/06/2025 22:00:08 ******/
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
	[document_path] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
ALTER TABLE [dbo].[campaigns] ADD  DEFAULT ('news') FOR [status]
GO
ALTER TABLE [dbo].[campaigns] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[campaigns] ADD  DEFAULT ('pending') FOR [admin_status]
GO
ALTER TABLE [dbo].[contact_requests] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[contact_requests] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[content_moderation] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[content_moderation] ADD  DEFAULT (getdate()) FOR [moderated_at]
GO
ALTER TABLE [dbo].[join_requests] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[join_requests] ADD  DEFAULT (getdate()) FOR [created_at]
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
ALTER TABLE [dbo].[contact_requests]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[content_moderation]  WITH CHECK ADD FOREIGN KEY([moderator_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[join_requests]  WITH CHECK ADD FOREIGN KEY([campaign_id])
REFERENCES [dbo].[campaigns] ([campaign_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD FOREIGN KEY([receiver_id])
REFERENCES [dbo].[users] ([user_id])
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
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD CHECK  (([admin_status]='rejected' OR [admin_status]='accepted' OR [admin_status]='pending'))
GO
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[campaigns]  WITH CHECK ADD CHECK  (([status]='cancelled' OR [status]='completed' OR [status]='active' OR [status]='news'))
GO
ALTER TABLE [dbo].[contact_requests]  WITH CHECK ADD CHECK  (([status]='resolved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[content_moderation]  WITH CHECK ADD CHECK  (([status]='rejected' OR [status]='approved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[content_moderation]  WITH CHECK ADD CHECK  (([status]='rejected' OR [status]='approved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[join_requests]  WITH CHECK ADD CHECK  (([status]='rejected' OR [status]='approved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[messages]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD CHECK  (([status]='cancelled' OR [status]='completed' OR [status]='pending'))
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD CHECK  (([status]='cancelled' OR [status]='completed' OR [status]='pending'))
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD CHECK  (([language]='en' OR [language]='vi'))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([role]='admin' OR [role]='buyer' OR [role]='farmer'))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([role]='admin' OR [role]='buyer' OR [role]='farmer'))
GO


-- Kiểm tra dữ liệu
SELECT * FROM users
SELECT * FROM products
SELECT * FROM campaigns
GO

-- 1) Xóa trigger cũ
IF OBJECT_ID('trg_HandleCampaignStatus','TR') IS NOT NULL
    DROP TRIGGER trg_HandleCampaignStatus;
GO

-- 2) Tạo trigger mới
CREATE TRIGGER trg_HandleCampaignStatus
ON campaigns
INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Chặn chỉnh sửa status thủ công khi admin_status không đổi
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deleted d ON i.campaign_id = d.campaign_id
        WHERE i.status    <> d.status
          AND ISNULL(i.admin_status,'') = ISNULL(d.admin_status,'')
          AND i.status   <> 'completed'
    )
    BEGIN
        RAISERROR(
          N'Không được chỉnh trực tiếp cột "status". Vui lòng dùng "admin_status".',
          16, 1
        );
        ROLLBACK;
        RETURN;
    END;

    -- Cập nhật admin_status, image_url và tự set status
    UPDATE c
    SET
        admin_status = i.admin_status,
        image_url    = i.image_url,
        status       = CASE 
                           WHEN i.admin_status = 'accepted' THEN 'active'
                           WHEN i.admin_status = 'rejected' THEN 'cancelled'
                           ELSE c.status
                       END
    FROM campaigns c
    JOIN inserted i ON c.campaign_id = i.campaign_id;
END;
GO


DECLARE
  @sql NVARCHAR(MAX) = N'';

;WITH uniques AS (
  SELECT
    cu.constraint_name,
    cu.column_name,
    ROW_NUMBER() OVER (
      PARTITION BY cu.column_name
      ORDER BY cu.constraint_name
    ) AS rn
  FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
  JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE cu
    ON tc.constraint_name = cu.constraint_name
  WHERE tc.table_name = 'users'
    AND tc.constraint_type = 'UNIQUE'
)
SELECT
  @sql += 'ALTER TABLE dbo.users DROP CONSTRAINT ' 
         + QUOTENAME(constraint_name) + ';' + CHAR(13)
FROM uniques
WHERE rn > 1;   -- giữ lại rn = 1, drop rn > 1

EXEC sp_executesql @sql;


ALTER TABLE dbo.users
  ADD CONSTRAINT UQ_users_email    UNIQUE(email),
      CONSTRAINT UQ_users_username UNIQUE(username);



 





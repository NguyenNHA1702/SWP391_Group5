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

ALTER TRIGGER trg_PreventManualStatusUpdate
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
        RAISERROR(N'Cột "status" không được chỉnh sửa trực tiếp. Vui lòng cập nhật thông qua "admin_status".', 16, 1);
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
        status = i.status,
        image_url = i.image_url         -- 👉 THÊM DÒNG NÀY
    FROM inserted i
    WHERE campaigns.campaign_id = i.campaign_id;
END;
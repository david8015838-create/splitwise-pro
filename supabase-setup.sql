-- SplitWise Pro Supabase 資料庫設置
-- 請在 Supabase SQL Editor 中執行此腳本

-- 1. 創建 rooms 表
CREATE TABLE IF NOT EXISTS public.rooms (
    id BIGSERIAL PRIMARY KEY,
    code TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    data JSONB NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 創建索引以提升查詢效能
CREATE INDEX IF NOT EXISTS idx_rooms_code ON public.rooms(code);
CREATE INDEX IF NOT EXISTS idx_rooms_updated_at ON public.rooms(updated_at);

-- 3. 啟用 Row Level Security (RLS)
ALTER TABLE public.rooms ENABLE ROW LEVEL SECURITY;

-- 4. 創建政策：允許所有人讀取和寫入（因為是公開分帳應用）
CREATE POLICY "允許所有人讀取房間" ON public.rooms
    FOR SELECT USING (true);

CREATE POLICY "允許所有人創建房間" ON public.rooms
    FOR INSERT WITH CHECK (true);

CREATE POLICY "允許所有人更新房間" ON public.rooms
    FOR UPDATE USING (true);

CREATE POLICY "允許所有人刪除房間" ON public.rooms
    FOR DELETE USING (true);

-- 5. 創建自動更新 updated_at 的函數
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 6. 創建觸發器
DROP TRIGGER IF EXISTS update_rooms_updated_at ON public.rooms;
CREATE TRIGGER update_rooms_updated_at
    BEFORE UPDATE ON public.rooms
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 7. 創建自動清理過期資料的函數（刪除 30 天前的資料）
CREATE OR REPLACE FUNCTION delete_old_rooms()
RETURNS void AS $$
BEGIN
    DELETE FROM public.rooms
    WHERE updated_at < NOW() - INTERVAL '30 days';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 8. 啟用 Realtime（即時同步功能）
-- 注意：這個需要在 Supabase Dashboard > Database > Replication 中手動啟用
-- 或執行以下命令：
ALTER PUBLICATION supabase_realtime ADD TABLE public.rooms;

-- 9. 創建定時任務清理過期資料（使用 pg_cron 擴展）
-- 注意：需要先在 Supabase Dashboard > Database > Extensions 中啟用 pg_cron
-- 如果您的 Supabase 計劃支持 pg_cron，取消下面的註釋：

/*
-- 啟用 pg_cron 擴展
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- 每天凌晨 2 點執行清理
SELECT cron.schedule(
    'delete-old-rooms',
    '0 2 * * *',
    'SELECT delete_old_rooms();'
);
*/

-- 完成！
-- 接下來請：
-- 1. 在 Supabase Dashboard 取得您的 URL 和 ANON_KEY
-- 2. 將它們填入 index.html 中的 SUPABASE_URL 和 SUPABASE_ANON_KEY
-- 3. 在 Database > Replication 中啟用 rooms 表的 Realtime

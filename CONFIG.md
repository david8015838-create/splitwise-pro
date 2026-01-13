# 配置說明

## Supabase 配置

### 1. 取得 Supabase 憑證

前往您的 Supabase 專案：
- Dashboard URL: https://app.supabase.com
- 選擇您的專案
- 前往 `Settings > API`

您需要以下三個值：

```
Project URL: https://xxxxx.supabase.co
anon public key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
service_role key: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

### 2. 更新 index.html

在 `index.html` 文件中找到以下代碼：

```javascript
// Supabase 配置 - 請替換為您的實際值
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

替換為：

```javascript
// Supabase 配置
const SUPABASE_URL = 'https://xxxxx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

### 3. 設置 GitHub Secrets（用於 GitHub Actions）

前往 GitHub 專案：
- `Settings > Secrets and variables > Actions`
- 點擊 `New repository secret`

添加以下三個 secrets：

| Name | Value |
|------|-------|
| `SUPABASE_URL` | https://xxxxx.supabase.co |
| `SUPABASE_ANON_KEY` | eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9... |
| `SUPABASE_SERVICE_KEY` | eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9... |

⚠️ **重要**: `service_role` key 具有完整權限，請妥善保管，僅用於 GitHub Actions！

## 資料庫設置

1. 在 Supabase SQL Editor 執行 `supabase-setup.sql`
2. 前往 `Database > Replication` 
3. 找到 `rooms` 表並啟用 Realtime

## 測試配置

### 測試資料庫連接

在瀏覽器控制台執行：

```javascript
// 測試連接
const { data, error } = await supabase.from('rooms').select('count');
console.log('連接測試:', error ? '失敗' : '成功', data);
```

### 測試 GitHub Action

1. 前往 GitHub 專案的 `Actions` 頁面
2. 選擇 `Keep Supabase Active` workflow
3. 點擊 `Run workflow` 手動觸發
4. 查看執行結果

## 常見問題

### Q: 如何確認 Realtime 已啟用？
A: 前往 Supabase Dashboard > Database > Replication，確認 `rooms` 表在列表中。

### Q: GitHub Action 執行失敗怎麼辦？
A: 
1. 檢查 Secrets 是否正確設置
2. 查看 Action 日誌中的錯誤訊息
3. 確認 Supabase 專案沒有暫停

### Q: 如何手動清理過期資料？
A: 在 Supabase SQL Editor 執行：
```sql
SELECT delete_old_rooms();
```

### Q: 可以修改自動清理的天數嗎？
A: 可以，修改 `supabase-setup.sql` 中的：
```sql
WHERE updated_at < NOW() - INTERVAL '30 days';
```
將 `30 days` 改為您想要的天數。

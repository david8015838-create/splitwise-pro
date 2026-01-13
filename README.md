# SplitWise Pro

一個現代化的分帳應用，支援雲端即時同步、深色/淺色模式切換。

## ✨ 功能特色

- 🌐 **雲端即時同步** - 使用 Supabase 實現多人即時協作
- 🌓 **深色/淺色模式** - 支援主題切換
- 💰 **智能分帳** - 支援平均分攤和手動分配
- 📊 **自動結算** - 智能計算最少還款次數
- 📱 **響應式設計** - 完美適配手機和桌面
- 🔄 **自動清理** - 30 天自動清理過期資料
- 🚀 **零後端部署** - 純前端應用，部署簡單

## 🚀 快速開始

### 1. 設置 Supabase

1. 前往 [Supabase](https://supabase.com) 創建免費帳號
2. 創建一個新專案
3. 在 SQL Editor 中執行 `supabase-setup.sql` 文件中的 SQL 腳本
4. 前往 `Database > Replication` 啟用 `rooms` 表的 Realtime
5. 前往 `Settings > API` 取得：
   - `Project URL` (SUPABASE_URL)
   - `anon public` key (SUPABASE_ANON_KEY)
   - `service_role` key (SUPABASE_SERVICE_KEY) - 僅用於 GitHub Actions

### 2. 配置應用

在 `index.html` 中找到以下行並替換為您的實際值：

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

### 3. 設置 GitHub Actions（可選但推薦）

GitHub Actions 會：
- 每天自動 ping 資料庫，防止 Supabase 免費版因閒置而暫停
- 自動清理 30 天前的過期資料

**設置步驟：**

1. 將專案推送到 GitHub
2. 前往 GitHub 專案的 `Settings > Secrets and variables > Actions`
3. 添加以下 Secrets：
   - `SUPABASE_URL`: 您的 Supabase Project URL
   - `SUPABASE_ANON_KEY`: 您的 anon public key
   - `SUPABASE_SERVICE_KEY`: 您的 service_role key（用於刪除過期資料）

4. GitHub Action 會在每天凌晨 2 點（UTC）自動執行

### 4. 部署

#### 選項 A: GitHub Pages
```bash
# 1. 推送到 GitHub
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin YOUR_GITHUB_REPO_URL
git push -u origin main

# 2. 在 GitHub 專案設置中啟用 GitHub Pages
# Settings > Pages > Source: main branch
```

#### 選項 B: Vercel
```bash
# 安裝 Vercel CLI
npm i -g vercel

# 部署
vercel
```

#### 選項 C: Netlify
直接拖放專案資料夾到 [Netlify Drop](https://app.netlify.com/drop)

## 📊 資料庫結構

### rooms 表

| 欄位 | 類型 | 說明 |
|------|------|------|
| id | BIGSERIAL | 主鍵 |
| code | TEXT | 房間代碼（6位數字） |
| name | TEXT | 房間名稱 |
| data | JSONB | 房間資料（成員、支出等） |
| created_at | TIMESTAMPTZ | 創建時間 |
| updated_at | TIMESTAMPTZ | 更新時間 |

## 🔒 安全性說明

- 使用 Supabase Row Level Security (RLS) 保護資料
- 房間代碼為 6 位數字，提供基本的訪問控制
- 建議：如需更高安全性，可添加密碼保護功能

## 🧹 資料清理

- **自動清理**：GitHub Action 每天自動刪除 30 天前未更新的房間
- **手動清理**：在 Supabase SQL Editor 執行：
  ```sql
  SELECT delete_old_rooms();
  ```

## 📝 開發說明

### 本地開發

直接用瀏覽器打開 `index.html` 即可，或使用簡單的 HTTP 伺服器：

```bash
# Python 3
python -m http.server 8000

# Node.js
npx serve

# PHP
php -S localhost:8000
```

### 技術棧

- **前端框架**: React 18 (CDN)
- **樣式**: Tailwind CSS (CDN)
- **資料庫**: Supabase (PostgreSQL + Realtime)
- **部署**: 靜態網站託管（GitHub Pages / Vercel / Netlify）

## 🐛 疑難排解

### 資料無法同步
1. 檢查 Supabase URL 和 API Key 是否正確
2. 確認已在 Supabase Dashboard 啟用 Realtime
3. 檢查瀏覽器控制台是否有錯誤訊息

### GitHub Action 失敗
1. 確認已正確設置所有 Secrets
2. 檢查 Supabase 專案是否正常運行
3. 查看 Actions 頁面的錯誤日誌

### Supabase 免費版限制
- 500MB 資料庫空間
- 2GB 檔案儲存
- 50,000 月活躍用戶
- 7 天不活躍會暫停（GitHub Action 可防止）

## 📄 授權

MIT License

## 👨‍💻 作者

BY OWEN

---

如有問題或建議，歡迎提出 Issue！

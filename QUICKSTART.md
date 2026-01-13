# 🚀 快速開始指南

## 步驟 1: 設置 Supabase（5 分鐘）

### 1.1 創建 Supabase 專案
1. 前往 https://supabase.com 註冊/登入
2. 點擊 "New Project"
3. 填寫專案資訊：
   - Name: `splitwise-pro`
   - Database Password: 設置一個強密碼（請記住）
   - Region: 選擇 `Northeast Asia (Tokyo)` 或最近的區域
4. 點擊 "Create new project"（需要等待 1-2 分鐘）

### 1.2 執行 SQL 腳本
1. 專案創建完成後，點擊左側 `SQL Editor`
2. 點擊 `New query`
3. 複製 `supabase-setup.sql` 的全部內容並貼上
4. 點擊 `Run` 執行（應該會看到 "Success" 訊息）

### 1.3 啟用 Realtime
1. 點擊左側 `Database > Replication`
2. 找到 `rooms` 表
3. 點擊旁邊的開關，啟用 Realtime
4. 確認狀態變為綠色 ✅

### 1.4 取得 API 金鑰
1. 點擊左側 `Settings > API`
2. 複製以下資訊：
   ```
   Project URL: https://xxxxx.supabase.co
   anon public: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   service_role: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   ```

## 步驟 2: 配置應用（1 分鐘）

### 2.1 更新 index.html
打開 `index.html`，找到第 108-109 行：

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

替換為您的實際值：

```javascript
const SUPABASE_URL = 'https://xxxxx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

💾 儲存文件

## 步驟 3: 測試應用（1 分鐘）

### 3.1 本地測試
用瀏覽器直接打開 `index.html`，或使用：

```bash
# Python 3
python -m http.server 8000
# 然後訪問 http://localhost:8000

# 或使用 Node.js
npx serve
```

### 3.2 測試功能
1. 輸入活動名稱和暱稱，點擊「建立房間」
2. 添加成員
3. 新增一筆支出
4. 打開另一個瀏覽器視窗，使用相同房號進入
5. 在任一視窗修改資料，確認另一視窗即時同步 ✨

## 步驟 4: 部署到線上（3 分鐘）

### 選項 A: Vercel（推薦）
```bash
# 1. 安裝 Vercel CLI
npm i -g vercel

# 2. 部署
vercel

# 3. 按照提示操作，完成！
```

### 選項 B: GitHub Pages
```bash
# 1. 初始化 Git
git init
git add .
git commit -m "Initial commit"

# 2. 推送到 GitHub
git remote add origin https://github.com/你的用戶名/splitwise-pro.git
git branch -M main
git push -u origin main

# 3. 在 GitHub 專案設置中啟用 Pages
# Settings > Pages > Source: main branch > Save
```

### 選項 C: Netlify
1. 前往 https://app.netlify.com/drop
2. 直接拖放整個專案資料夾
3. 完成！

## 步驟 5: 設置 GitHub Actions（可選，3 分鐘）

這會讓您的 Supabase 免費版不會因閒置而暫停，並自動清理過期資料。

### 5.1 推送到 GitHub
如果還沒推送，執行：
```bash
git init
git add .
git commit -m "Add GitHub Actions"
git remote add origin https://github.com/你的用戶名/splitwise-pro.git
git branch -M main
git push -u origin main
```

### 5.2 設置 Secrets
1. 前往 GitHub 專案頁面
2. 點擊 `Settings > Secrets and variables > Actions`
3. 點擊 `New repository secret`
4. 添加三個 secrets：

| Name | Value |
|------|-------|
| `SUPABASE_URL` | https://xxxxx.supabase.co |
| `SUPABASE_ANON_KEY` | 您的 anon public key |
| `SUPABASE_SERVICE_KEY` | 您的 service_role key |

### 5.3 測試 Action
1. 前往 `Actions` 頁面
2. 選擇 `Keep Supabase Active`
3. 點擊 `Run workflow` > `Run workflow`
4. 等待執行完成，應該會看到綠色 ✅

## 🎉 完成！

現在您的應用已經：
- ✅ 部署到線上
- ✅ 支援多人即時協作
- ✅ 自動清理過期資料
- ✅ 防止 Supabase 暫停

## 📱 分享給朋友

將部署後的網址分享給朋友：
- Vercel: `https://your-app.vercel.app`
- GitHub Pages: `https://你的用戶名.github.io/splitwise-pro`
- Netlify: `https://your-app.netlify.app`

## ❓ 遇到問題？

### 資料無法同步
- 檢查瀏覽器控制台是否有錯誤
- 確認 Supabase URL 和 Key 是否正確
- 確認已啟用 Realtime

### GitHub Action 失敗
- 檢查 Secrets 是否正確設置
- 查看 Action 日誌的錯誤訊息

### 其他問題
查看 `README.md` 的疑難排解章節，或在 GitHub 提出 Issue。

---

**需要幫助？** 查看 `CONFIG.md` 了解詳細配置說明。

# 更新日誌

## [2.0.0] - 2026-01-13

### 🎉 重大更新

#### 從 Gun.js (P2P) 遷移到 Supabase
- **移除**: Gun.js P2P 同步
- **新增**: Supabase PostgreSQL 資料庫
- **新增**: Supabase Realtime 即時同步
- **優勢**: 
  - 更穩定的資料持久化
  - 更快的同步速度
  - 更好的資料查詢能力
  - 支援複雜的資料操作

### ✨ 新功能

#### 1. 深色/淺色模式切換
- 在所有頁面右上角添加主題切換按鈕
- 支援平滑過渡動畫
- 自動保存用戶偏好設置
- 完整的顏色系統適配

#### 2. 自動清理過期資料
- 自動刪除 30 天前未更新的房間
- 防止資料庫過載
- 保護用戶隱私
- 可透過 SQL 函數手動觸發

#### 3. GitHub Actions 自動化
- 每天凌晨自動執行
- Ping 資料庫防止 Supabase 免費版暫停
- 自動清理過期資料
- 執行日誌記錄

### 📝 文檔完善

新增文檔：
- `README.md` - 完整文檔
- `QUICKSTART.md` - 5 分鐘快速開始
- `CONFIG.md` - 詳細配置說明
- `PROJECT-OVERVIEW.md` - 項目總覽
- `DEPLOYMENT-CHECKLIST.md` - 部署檢查清單
- `GETTING-STARTED.txt` - ASCII 藝術指南
- `CHANGELOG.md` - 本文件

新增工具：
- `test-connection.html` - Supabase 連接測試工具
- `supabase-setup.sql` - 資料庫初始化腳本

新增配置：
- `package.json` - NPM 配置
- `.gitignore` - Git 忽略文件
- `LICENSE` - MIT 授權

### 🔧 技術改進

#### 資料庫
- 使用 PostgreSQL JSONB 存儲房間資料
- 添加索引優化查詢效能
- 啟用 Row Level Security (RLS)
- 自動更新 updated_at 時間戳

#### 前端
- 改用 Supabase JS Client
- 實現 Realtime 訂閱
- 優化錯誤處理
- 改進載入狀態

#### DevOps
- GitHub Actions 工作流程
- 自動化測試和清理
- 部署配置優化

### 🎨 UI/UX 改進

#### 主題系統
- 完整的深色模式支援
- 淺色模式支援
- 平滑的顏色過渡
- 一致的設計語言

#### 視覺優化
- 更新標語：「P2P 即時同步」→「雲端即時同步」
- 優化刪除確認提示文字
- 改進按鈕佈局（房間頁面）
- 統一圖標樣式

### 🔒 安全性

- 使用 Supabase RLS 保護資料
- API Key 分離（anon key vs service key）
- HTTPS 加密傳輸
- 自動清理敏感資料

### 📊 效能優化

- 資料庫索引優化
- Realtime 訂閱優化
- 減少不必要的重新渲染
- 優化資料查詢

### 🐛 修復

- 修復多人同時編輯的衝突問題
- 改進錯誤處理和提示
- 優化載入狀態顯示
- 修復主題切換的閃爍問題

### 📦 依賴更新

- 移除: `gun.js`
- 新增: `@supabase/supabase-js@2`
- 保持: React 18, Tailwind CSS

### 🚀 部署支援

新增部署平台支援：
- Vercel（推薦）
- GitHub Pages
- Netlify
- 任何靜態網站託管

### 📱 兼容性

測試並確認支援：
- Chrome 90+
- Safari 14+
- Firefox 88+
- Edge 90+
- 移動端瀏覽器

### 🔄 遷移指南

從 v1.x 遷移到 v2.0：

1. **設置 Supabase**
   ```bash
   # 1. 創建 Supabase 專案
   # 2. 執行 supabase-setup.sql
   # 3. 啟用 Realtime
   ```

2. **更新配置**
   ```javascript
   // 在 index.html 中更新
   const SUPABASE_URL = 'your-url';
   const SUPABASE_ANON_KEY = 'your-key';
   ```

3. **資料遷移**
   - 舊資料無法自動遷移
   - 建議用戶重新創建房間
   - 或手動匯出/匯入資料

### ⚠️ 破壞性變更

- **不兼容 v1.x 的資料格式**
- **需要 Supabase 帳號**
- **需要網路連接才能使用**

### 📈 統計

- 新增代碼：~500 行
- 新增文檔：~2000 行
- 新增文件：12 個
- 測試覆蓋：手動測試通過

### 🙏 致謝

感謝以下開源項目：
- [Supabase](https://supabase.com) - 開源的 Firebase 替代方案
- [React](https://react.dev) - UI 框架
- [Tailwind CSS](https://tailwindcss.com) - CSS 框架

---

## [1.0.0] - 2025-XX-XX

### 初始版本

- 基本分帳功能
- Gun.js P2P 同步
- 平均/手動分配
- 自動結算
- 響應式設計

---

**版本命名規則**: [主版本].[次版本].[修訂版本]

- **主版本**: 重大更新，可能不向後兼容
- **次版本**: 新功能，向後兼容
- **修訂版本**: Bug 修復，向後兼容

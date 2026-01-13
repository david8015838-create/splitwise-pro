# 📦 SplitWise Pro - 項目總覽

## 🎯 項目簡介

SplitWise Pro 是一個現代化的分帳應用，使用 Supabase 實現雲端即時同步，支援多人協作、自動結算、深色/淺色模式切換等功能。

## 📁 項目結構

```
splitwise-pro/
├── .github/
│   └── workflows/
│       └── keep-supabase-active.yml    # GitHub Action：保持資料庫活躍 + 清理過期資料
├── .gitignore                          # Git 忽略文件
├── CONFIG.md                           # 詳細配置說明
├── DEPLOYMENT-CHECKLIST.md            # 部署檢查清單
├── LICENSE                             # MIT 授權
├── QUICKSTART.md                       # 快速開始指南（5分鐘上手）
├── README.md                           # 完整文檔
├── PROJECT-OVERVIEW.md                 # 本文件
├── index.html                          # 主應用文件（單頁應用）
├── package.json                        # NPM 配置（用於部署）
├── supabase-setup.sql                  # Supabase 資料庫初始化腳本
└── test-connection.html                # Supabase 連接測試工具
```

## 🚀 核心功能

### 1. 房間管理
- ✅ 創建房間（6位數房號）
- ✅ 加入房間（通過房號）
- ✅ 房間歷史記錄（最近訪問）
- ✅ URL Hash 支援（可分享連結）

### 2. 成員管理
- ✅ 添加成員
- ✅ 刪除成員
- ✅ 成員列表顯示

### 3. 支出管理
- ✅ 新增支出
- ✅ 平均分攤模式
- ✅ 手動分配模式
- ✅ 支出列表（最新在上）
- ✅ 刪除支出

### 4. 結算功能
- ✅ 自動計算收支平衡
- ✅ 智能還款建議（最少交易次數）
- ✅ 詳細消費明細
- ✅ 分享結算報告（複製到剪貼板）

### 5. UI/UX
- ✅ 深色/淺色模式切換
- ✅ 響應式設計（手機/桌面）
- ✅ 玻璃擬態設計
- ✅ 平滑動畫效果
- ✅ Toast 通知

### 6. 雲端同步
- ✅ Supabase Realtime 即時同步
- ✅ 多人協作
- ✅ 自動衝突解決
- ✅ 離線支援（LocalStorage）

### 7. 資料管理
- ✅ 自動清理 30 天過期資料
- ✅ GitHub Action 定時任務
- ✅ 防止資料庫閒置暫停

## 🛠️ 技術棧

### 前端
- **框架**: React 18 (CDN)
- **樣式**: Tailwind CSS (CDN)
- **圖標**: 自定義 SVG 圖標
- **字體**: Noto Sans TC (Google Fonts)

### 後端
- **資料庫**: Supabase (PostgreSQL)
- **即時同步**: Supabase Realtime
- **認證**: Row Level Security (RLS)

### DevOps
- **CI/CD**: GitHub Actions
- **部署**: Vercel / GitHub Pages / Netlify
- **版本控制**: Git

## 📊 資料庫架構

### rooms 表

```sql
CREATE TABLE rooms (
    id BIGSERIAL PRIMARY KEY,
    code TEXT UNIQUE NOT NULL,           -- 房間代碼
    name TEXT NOT NULL,                  -- 房間名稱
    data JSONB NOT NULL,                 -- 房間資料
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

### data JSONB 結構

```json
{
  "code": "123456",
  "name": "週末小旅行",
  "members": [
    {
      "id": "m_1234567890",
      "name": "小明"
    }
  ],
  "expenses": [
    {
      "id": "e_1234567890",
      "title": "晚餐",
      "amount": 500,
      "payerId": "m_1234567890",
      "participants": ["m_1234567890", "m_9876543210"],
      "splitMode": "equal",
      "customAmounts": {}
    }
  ]
}
```

## 🔄 工作流程

### 用戶流程
1. 訪問網站
2. 創建房間或輸入房號加入
3. 添加成員
4. 記錄支出
5. 查看結算報告
6. 分享給朋友

### 資料同步流程
1. 用戶操作（新增/修改/刪除）
2. 更新本地 State
3. 呼叫 Supabase API
4. Supabase 更新資料庫
5. Realtime 推送更新
6. 其他用戶收到更新
7. 自動更新 UI

### GitHub Action 流程
1. 每天凌晨 2:00 UTC 觸發
2. Ping Supabase 資料庫
3. 刪除 30 天前的資料
4. 記錄執行結果

## 📈 效能優化

### 前端優化
- ✅ useMemo 緩存計算結果
- ✅ 防抖輸入處理
- ✅ 虛擬滾動（未來）
- ✅ 圖片懶加載（未來）

### 資料庫優化
- ✅ 索引優化（code, updated_at）
- ✅ JSONB 欄位存儲
- ✅ 自動清理過期資料
- ✅ 連接池管理（Supabase 自動）

## 🔒 安全性

### 資料安全
- ✅ Row Level Security (RLS)
- ✅ API Key 保護
- ✅ HTTPS 加密傳輸

### 隱私保護
- ✅ 無需註冊
- ✅ 無個人資料收集
- ✅ 30 天自動清理

## 📱 瀏覽器支援

- ✅ Chrome 90+
- ✅ Safari 14+
- ✅ Firefox 88+
- ✅ Edge 90+
- ✅ 移動端瀏覽器

## 🎨 設計系統

### 顏色
- **主色**: Indigo (#4F46E5)
- **深色背景**: Slate-950 (#020617)
- **淺色背景**: Slate-100 (#f1f5f9)
- **成功**: Green-400
- **錯誤**: Rose-400

### 字體
- **主字體**: Noto Sans TC
- **字重**: 400 (Regular), 700 (Bold), 900 (Black)

### 圓角
- **小**: 12px
- **中**: 24px
- **大**: 32px

## 📝 開發規範

### Git Commit 規範
```
feat: 新功能
fix: 修復 bug
docs: 文檔更新
style: 樣式調整
refactor: 重構
test: 測試
chore: 雜項
```

### 代碼風格
- 使用 2 空格縮排
- 使用單引號
- 使用 ES6+ 語法
- 組件使用 PascalCase
- 函數使用 camelCase

## 🚧 未來計劃

### v2.1
- [ ] 支出分類標籤
- [ ] 圖表統計
- [ ] 匯出 Excel/PDF
- [ ] 多貨幣支援

### v2.2
- [ ] 照片上傳（收據）
- [ ] 備註功能
- [ ] 搜尋功能
- [ ] 排序功能

### v2.3
- [ ] 用戶系統
- [ ] 房間密碼保護
- [ ] 權限管理
- [ ] 通知系統

## 📞 聯絡方式

- **作者**: OWEN
- **GitHub**: [您的 GitHub]
- **Email**: [您的 Email]

## 📄 授權

MIT License - 詳見 LICENSE 文件

---

**最後更新**: 2026-01-13
**版本**: 2.0.0

#!/bin/bash

# SplitWise Pro 測試腳本

echo "🚀 SplitWise Pro v2.0 測試腳本"
echo "================================"
echo ""

# 檢查 Python
if command -v python3 &> /dev/null; then
    echo "✅ Python 3 已安裝"
else
    echo "❌ Python 3 未安裝"
    exit 1
fi

# 檢查端口
if lsof -Pi :8000 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo "✅ 本地伺服器已在運行 (端口 8000)"
else
    echo "⚠️  本地伺服器未運行，正在啟動..."
    cd "$(dirname "$0")"
    python3 -m http.server 8000 > /dev/null 2>&1 &
    sleep 2
    echo "✅ 本地伺服器已啟動"
fi

echo ""
echo "📱 應用連結："
echo "   測試工具: http://localhost:8000/test-connection.html"
echo "   主應用:   http://localhost:8000/index.html"
echo ""
echo "🔧 Supabase 配置："
echo "   URL: https://azihzilwffcyhksflbdk.supabase.co"
echo "   Key: 已設置 ✅"
echo ""
echo "📋 測試步驟："
echo "   1. 打開測試工具，確認所有測試通過"
echo "   2. 打開主應用，創建房間"
echo "   3. 添加成員和支出"
echo "   4. 測試即時同步（開兩個視窗）"
echo "   5. 測試深色/淺色模式"
echo ""
echo "🚀 準備部署？執行："
echo "   vercel              # Vercel 部署"
echo "   git push origin main # GitHub Pages"
echo ""
echo "💡 需要幫助？查看："
echo "   ✅-下一步指南.md"
echo "   🎉-完成通知.md"
echo "   ⚡-快速參考.md"
echo ""
echo "================================"
echo "按 Ctrl+C 停止伺服器"

LOG_FILE="access.log"
REPORT_FILE="report.txt"

cat <<EOL > "$LOG_FILE"
192.168.1.1 - - [28/Jul/2024:12:34:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [28/Jul/2024:12:35:56 +0000] "POST /login HTTP/1.1" 200 567
192.168.1.3 - - [28/Jul/2024:12:36:56 +0000] "GET /home HTTP/1.1" 404 890
192.168.1.1 - - [28/Jul/2024:12:37:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - [28/Jul/2024:12:38:56 +0000] "GET /about HTTP/1.1" 200 432
192.168.1.2 - - [28/Jul/2024:12:39:56 +0000] "GET /index.html HTTP/1.1" 200 1234
EOL

# Анализ
TOTAL_REQUESTS=$(wc -l < "$LOG_FILE")
UNIQUE_IPS=$(awk '{ip = $1; ips[ip]++} END {count = 0; for (i in ips) count++; print count}' "$LOG_FILE")
GET_COUNT=$(awk -F'"' '{method = $2; split(method, arr, " "); methods[arr[1]]++} END {print methods["GET"]+0}' "$LOG_FILE")
POST_COUNT=$(awk -F'"' '{method = $2; split(method, arr, " "); methods[arr[1]]++} END {print methods["POST"]+0}' "$LOG_FILE")

POPULAR_INFO=$(awk -F'"' '{request = $2; split(request, arr, " "); urls[arr[2]]++} END {max=0; popular=""; for (url in urls) if (urls[url] > max) {max=urls[url]; popular=url}; print max, popular}' "$LOG_FILE")

POPULAR_COUNT=$(echo "$POPULAR_INFO" | awk '{print $1}')
POPULAR_URL=$(echo "$POPULAR_INFO" | awk '{print $2}')

# Отчет
cat > "$REPORT_FILE" << EOREPORT
Отчет о логе веб-сервера
========================
Общее количество запросов:    $TOTAL_REQUESTS
Количество уникальных IP-адресов:    $UNIQUE_IPS

Количество запросов по методам:
  $GET_COUNT GET
  $POST_COUNT POST

Самый популярный URL:    $POPULAR_COUNT $POPULAR_URL
EOREPORT

cat "$REPORT_FILE"
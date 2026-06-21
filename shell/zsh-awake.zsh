# Keep Mac awake using built-in macOS caffeinate, in background
_awake_pid_file="$HOME/.cache/caffeinate-awake.pid"
_awake_log_file="/tmp/caffeinate-awake.log"

_awake_start() {
  local seconds="${1:-}"
  mkdir -p "$HOME/.cache"

  if [ -f "$_awake_pid_file" ]; then
    local old_pid
    old_pid="$(cat "$_awake_pid_file" 2>/dev/null)"
    if [ -n "$old_pid" ] && kill -0 "$old_pid" 2>/dev/null; then
      echo "Already keeping Mac awake. PID: $old_pid"
      return 0
    fi
    rm -f "$_awake_pid_file"
  fi

  if [ -n "$seconds" ]; then
    nohup caffeinate -dimsu -t "$seconds" >"$_awake_log_file" 2>&1 &
  else
    nohup caffeinate -dimsu >"$_awake_log_file" 2>&1 &
  fi

  local pid=$!
  echo "$pid" > "$_awake_pid_file"
  disown "$pid" 2>/dev/null || true
  echo "Mac awake started in background. PID: $pid"
}

awake() { _awake_start; }
awake1h() { _awake_start 3600; }
awake2h() { _awake_start 7200; }

awake_status() {
  if [ -f "$_awake_pid_file" ]; then
    local pid
    pid="$(cat "$_awake_pid_file" 2>/dev/null)"
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      echo "Mac awake is active. PID: $pid"
      return 0
    fi
  fi
  echo "Mac awake is not active from this helper."
}

awake_stop() {
  if [ -f "$_awake_pid_file" ]; then
    local pid
    pid="$(cat "$_awake_pid_file" 2>/dev/null)"
    if [ -n "$pid" ] && kill -0 "$pid" 2>/dev/null; then
      kill "$pid"
      rm -f "$_awake_pid_file"
      echo "Stopped Mac awake. PID: $pid"
      return 0
    fi
  fi
  rm -f "$_awake_pid_file"
  echo "No active Mac awake PID found."
}

alias awake-status='awake_status'
alias awake-stop='awake_stop'

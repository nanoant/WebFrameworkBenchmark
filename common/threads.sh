if [ -f /proc/cpuinfo ]; then
	threads=$(cat /proc/cpuinfo | grep -i 'core id' | wc -l)
elif [ -d /System/Library ]; then
	threads=$(sysctl machdep.cpu.thread_count)
else
	threads=4
fi

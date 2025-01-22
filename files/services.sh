#!/bin/bash

# Function to display running and stopped services
show_services() {
    if command -v systemctl &> /dev/null; then
        echo "Systemd detected. Listing services..."
        
        # List all services with status (running or stopped)
        echo -e "\nRunning Services:"
        systemctl list-units --type=service --state=running --no-pager
        
        echo -e "\nStopped Services:"
        systemctl list-units --type=service --state=inactive --no-pager
        
    elif command -v service &> /dev/null; then
        echo "SysV init or Upstart detected. Listing services..."
        
        # List running services
        echo -e "\nRunning Services:"
        service --status-all 2>&1 | grep '+' | awk '{print $4}'
        
        # List stopped services
        echo -e "\nStopped Services:"
        service --status-all 2>&1 | grep '-' | awk '{print $4}'
        
    elif [ -d /etc/init.d ]; then
        echo "Traditional init.d detected. Listing services..."
        
        # List running services
        echo -e "\nRunning Services:"
        for service in /etc/init.d/*; do
            if ps -ef | grep -q "$(basename "$service")"; then
                echo "$(basename "$service")"
            fi
        done
        
        # List stopped services
        echo -e "\nStopped Services:"
        for service in /etc/init.d/*; do
            if ! ps -ef | grep -q "$(basename "$service")"; then
                echo "$(basename "$service")"
            fi
        done
    else
        echo "Unknown service manager. Cannot detect services."
        exit 1
    fi
}

# Run the function to display services
show_services

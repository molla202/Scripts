#!/bin/bash
exec > /dev/null 2>&1
sudo systemctl daemon-reload
sudo systemctl enable $BinaryName
sudo systemctl start $BinaryName
sudo systemctl restart $BinaryName
exec > /dev/tty 2>&1

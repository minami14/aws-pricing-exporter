#!/bin/bash

echo "source /usr/share/bash-completion/completions/git" >> "$HOME/.bashrc"
echo "complete -C '/usr/local/bin/aws_completer' aws" >> "$HOME/.bashrc"
echo ". <(docker completion bash)" >> /home/vscode/.bashrc
echo ". <(minikube completion bash)" >> /home/vscode/.bashrc

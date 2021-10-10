# escape=`

FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-14

ARG USERNAME=${USERNAME}

USER $USERNAME

RUN sudo apt-get update `
#persistant shell history
    && SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.zsh_history" `
    && sudo mkdir /commandhistory `
    && sudo touch /commandhistory/.zsh_history `
    && sudo chown -R $USERNAME /commandhistory `
    && echo $SNIPPET >> "/home/$USERNAME/.zsh_history" `
#vscode extensions fix
    && mkdir -p /home/$USERNAME/.vscode-server/extensions `
                /home/$USERNAME/.vscode-server-insiders/extensions `
    && chown -R $USERNAME /home/$USERNAME/.vscode-server `
                          /home/$USERNAME/.vscode-server-insiders

#aditional repos
RUN sudo apt-get install -y gnupg software-properties-common curl `
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - `
    && sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" `
    && sudo apt-get update

#terraform
RUN sudo apt-get install -y mc terraform `
    && sudo touch /home/$USERNAME/.zshrc && terraform -install-autocomplete `
#oh-my-posh
    && sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh `
    && sudo chmod +x /usr/local/bin/oh-my-posh `
    && mkdir /home/$USERNAME/.poshthemes `
    && wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O /home/$USERNAME/.poshthemes/themes.zip `
    && unzip /home/$USERNAME/.poshthemes/themes.zip -d /home/$USERNAME/.poshthemes `
    && sudo chmod 754 /home/$USERNAME/.poshthemes/*.json `
    && rm /home/$USERNAME/.poshthemes/themes.zip `
    && echo 'eval "$(oh-my-posh --init --shell zsh --config ~/.poshthemes/tp.omp.json)"' >> ~/.zshrc

RUN npm install -g pnpm

RUN sudo apt-get install python 3.6.1 `
    && curl https://pre-commit.com/install-local.py | python - `
    && echo 'export PATH=$HOME/bin:/usr/local/bin:/home/node/bin:$PATH' >> ~/.zshrc

#!/bin/bash

# Define diretorios
TOOLS_DIR="Ferramentas"
UNITEX_DIR="$TOOLS_DIR/Unitex-GramLab-3.3"
WORKSPACE_DIR="$UNITEX_DIR/workspace"
CONFIG_FILE="$HOME/.unitex.cfg"
CONFIG_FILE_SCRIPT=".config"

# cria o diretorio que receberá todas as ferramentas
mkdir -p "$TOOLS_DIR"

# descompacta as ferramentas
unzip -q apache-opennlp.zip -d "$TOOLS_DIR"
tar -xf jre-8u391-linux-x64.tar.gz -C "$TOOLS_DIR"
unzip -q mallet-2.0.8.zip -d "$TOOLS_DIR"
tar -xf Python-3.10.12.tgz -C "$TOOLS_DIR"

# inclui o path deste java no .bashrc
echo "# Atalhos para as ferramentas" >> ~/.bashrc
echo "JAVA_HOME=$(pwd)/$TOOLS_DIR/jre1.8.0_391" >> ~/.bashrc
echo "export JAVA_HOME" >> ~/.bashrc
echo "PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc
echo "export PATH" >> ~/.bashrc
# atualiza o .bashrc
source ~/.bashrc

# inclui o path do Unitex no .bashrc
#echo "UNITEX_PATH=$(pwd)/$TOOLS_DIR/Unitex-GramLab-3.3" >> ~/.bashrc
#echo "export UNITEX_PATH" >> ~/.bashrc
#echo "UNITEXTOOLS=\$UNITEX_PATH/App/UnitexToolLogger" >> ~/.bashrc
#echo "export UNITEXTOOLS" >> ~/.bashrc
#echo "DIRPORT=\$UNITEX_PATH/Portuguese (Brazil)" >> ~/.bashrc
#echo "export DIRPORT" >> ~/.bashrc

# Create .config file if it doesn't exist
touch "$CONFIG_FILE_SCRIPT"

# Add environment variables to .config
echo "JAVA_HOME=$(pwd)/$TOOLS_DIR/jre1.8.0_391" >> "$CONFIG_FILE_SCRIPT"
echo "PATH=\$JAVA_HOME/bin:\$PATH" >> "$CONFIG_FILE_SCRIPT"
echo "unitex=$(pwd)/$UNITEX_DIR/App/UnitexToolLogger" >> "$CONFIG_FILE_SCRIPT"
echo "dirPort=$UNITEX_PATH/Portuguese (Brazil)" >> "$CONFIG_FILE_SCRIPT"
echo "opennlp=$(pwd)/$TOOLS_DIR/apache-opennlp" >> "$CONFIG_FILE_SCRIPT"
echo "freeling=/usr/share/freeling/config/pt.cfg" >> "$CONFIG_FILE_SCRIPT"
echo "mallet=$(pwd)/$TOOLS_DIR/mallet-2.0.8" >> "$CONFIG_FILE_SCRIPT"
echo "concordAux=$UNITEX_PATH/Portuguese (Brazil)Alphabet_sort.txt" >> "$CONFIG_FILE_SCRIPT"

# instala o Unitex
./Unitex-GramLab-3.3-linux-x86_64.run --target "$UNITEX_DIR"

# cria workspace do Unitex
mkdir -p "$WORKSPACE_DIR"

# faz alteracoes do readme dos scripts da juliana
cp -r "$UNITEX_DIR/Portuguese (Brazil)/Graphs/Preprocessing/Sentence/" "$UNITEX_DIR/Portuguese (Brazil)/Graphs/Preprocessing/Sentence_Trabalho/"
mv Sentence.fst2 "$UNITEX_DIR/Portuguese (Brazil)/Graphs/Preprocessing/Sentence_Trabalho/" 

mv dela-en-public.bin "$UNITEX_DIR/Portuguese (Brazil)/Dela/"

# altera as inclui o workspace do Unitex no arquivo de configuração
echo "$(pwd)/$WORKSPACE_DIR" > "$CONFIG_FILE"

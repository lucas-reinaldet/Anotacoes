https://terminalroot.com.br/2015/08/45-exemplos-de-variaveis-e-arrays-em_19.html

FOLDER=`sudo find ~ -type d -name "*Projeto_muralha"`

IFS='/'

read -a strarr <<< "$FOLDER"

FOLDER=''

for val in "${strarr[@]}";
do
    FOLDER+='\'
    FOLDER+="${val}"
done

IFS=''
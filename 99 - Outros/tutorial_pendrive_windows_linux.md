# 🧰 Tutorial: Criar um Pendrive Bootável do Windows no Linux (WoeUSB)

Este guia ensina passo a passo como criar um pendrive bootável do Windows 10 ou 11 usando Linux, de forma segura e confiável.

---

## ✅ Pré-requisitos

- Distribuição Linux baseada em Debian/Ubuntu (ex: Ubuntu, Pop!_OS, Mint)
- Pendrive com pelo menos **8 GB**
- ISO oficial do Windows (baixe em: https://www.microsoft.com/software-download/)

---

## 📦 Etapa 1: Instalar dependências

Abra o terminal e execute:

```bash
sudo apt update
sudo apt install git python3-pip p7zip-full python3-wxgtk4.0 grub-efi-amd64-bin
```

---

## 📥 Etapa 2: Baixar e instalar o WoeUSB-ng

```bash
cd ~/Downloads
git clone https://github.com/WoeUSB/WoeUSB-ng.git
cd WoeUSB-ng
sudo python3 setup.py install
```

---

## 🧭 Etapa 3: Identificar o seu pendrive

### 1. Plugue o pendrive na porta USB

Aguarde alguns segundos até o sistema reconhecê-lo.

### 2. Liste os dispositivos de armazenamento:

```bash
lsblk
```

Exemplo de saída:

```
NAME   MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sdb      8:16   1  14.9G  0 disk  /media/seu-usuario/PENDRIVE
nvme0n1 259:0   0 953.9G  0 disk  
├─nvme0n1p1 ...
```

### 3. Como saber qual é o pendrive?

- Normalmente aparece como `/dev/sdX`, onde **X é uma letra** (`a`, `b`, `c`...)
- O campo `RM` estará como `1` (removível)
- O **tamanho** confere com o pendrive (ex: 8G, 16G)
- Ele pode estar montado em `/media/<seu-usuario>/NOME_DO_PENDRIVE`

⚠️ **Cuidado:** não confunda com seu disco interno (geralmente `/dev/sda` ou `nvme0n1`)

---

## 🛑 Etapa 4: Desmontar o pendrive

Antes de gravar, desmonte:

```bash
sudo umount /dev/sdX*
```

(Substitua `sdX` pelo identificador do pendrive, como `sdb`)

---

## 🚀 Etapa 5: Criar o pendrive bootável com o Windows

Use o comando:

```bash
sudo PATH=$PATH:/usr/sbin woeusb --device /caminho/para/Windows.iso /dev/sdX --target-filesystem NTFS
```

Exemplo prático:

```bash
sudo PATH=$PATH:/usr/sbin woeusb --device ~/Downloads/Win11_24H2_BrazilianPortuguese_x64.iso /dev/sdb --target-filesystem NTFS
```

---

## 🧪 Etapa 6: Testar o pendrive

1. Reinicie o computador
2. Acesse o menu de boot (geralmente F12, F10, ESC ou DEL)
3. Selecione o pendrive como dispositivo de boot
4. Prossiga com a instalação do Windows

---

## 💡 Dica alternativa: Ventoy

Para múltiplas ISOs e uso mais prático, experimente o [Ventoy](https://www.ventoy.net/).

---

✅ Pronto! Agora você tem um pendrive bootável do Windows criado inteiramente via Linux.

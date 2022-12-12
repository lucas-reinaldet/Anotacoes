sudo apt purge youtube-dl 
sudo pip3 install youtube-dl
hash youtube-dl

# Opções de Qualidade do vídeo
youtube-dl -F https://youtu.be/plAdDEixMis

youtube-dl -F https://youtu.be/wx6hf3BLKx4


# Baixar video de qualidade selecionada
youtube-dl -f 137 https://youtu.be/plAdDEixMis

youtube-dl -f 398 https://youtu.be/wx6hf3BLKx4

# Baixar PlayList
youtube-dl -cit <playlist_url>

# Baixar Audio
youtube-dl -x <video_url>

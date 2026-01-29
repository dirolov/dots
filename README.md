# Disclaimer
Документация писалась нейросетью и дорабатывалась человеком.

# Dotfiles Configuration

Конфигурационные файлы для Sway + Waybar + Fish + Pywal окружения на Arch Linux.

## Обзор системы

- **WM**: sway (Wayland compositor)
- **Bar**: waybar
- **Shell**: fish
- **Terminal**: kitty
- **Launcher**: fuzzel
- **Notifications**: mako
- **File Manager**: thunar
- **Browser**: thorium-browser
- **Editor**: micro
- **Theming**: python-pywal16 + pywal16-libadwaita
- **Audio Visualizer**: cava
- **System Info**: fastfetch

## Установка зависимостей

### Основные пакеты
```bash
# Основная система
yay -S sway waybar fish kitty fuzzel mako thunar micro python-pywal16 fzf

# Дополнительные утилиты
yay -S cava fastfetch lsd most

# Шрифты
yay -S ttf-google-fonts-git nerd-fonts

# Дополнительные инструменты
yay -S xdg-desktop-portal-wlr mate-polkit sway-alttab-gui xwayland-satellite
```

### AUR пакеты
```bash
# Браузер
yay -S thorium-browser-bin

# Дополнительные утилиты
yay -S yt-dlp gradience walogram-git
```

## Основные кейбинды

### Sway Window Manager

| Комбинация | Действие |
|------------|----------|
| `Super + T` | Открыть терминал (Kitty) |
| `Super + Q` | Закрыть окно |
| `Super + D` | Открыть лаунчер (Fuzzel) |
| `Super + B` | Открыть браузер (Thorium) |
| `Super + E` | Открыть файловый менеджер (Thunar) |
| `Alt + Tab` | Переключение между окнами (sway-alttab-gui )|

### Навигация по окнам
| Комбинация | Действие |
|------------|----------|
| `Super + H/J/K/L` | Фокус влево/вниз/вверх/вправо |
| `Super + ←/↓/↑/→` | Фокус стрелками |
| `Super + Shift + H/J/K/L` | Переместить окно |
| `Super + Shift + ←/↓/↑/→` | Переместить окно стрелками |

### Рабочие столы
| Комбинация | Действие |
|------------|----------|
| `Super + 1-9,0` | Переключиться на рабочий стол |
| `Super + Shift + 1-9,0` | Переместить окно на рабочий стол |

### Раскладка окон
| Комбинация | Действие |
|------------|----------|
| `Super + Shift + B` | Горизонтальное разделение |
| `Super + Shift + V` | Вертикальное разделение |
| `Super + I` | Стековая раскладка |
| `Super + O` | Вкладочная раскладка |
| `Super + P` | Переключить раскладку |
| `Super + F` | Полноэкранный режим |
| `Super + Shift + F` | Плавающий режим |

### Система
| Комбинация | Действие |
|------------|----------|
| `Super + Shift + C` | Перезагрузить конфигурацию |
| `Super + Shift + E` | Выйти из Sway |
| `Win + Space` | Переключить раскладку клавиатуры (US/RU) |

## Конфигурация компонентов

### Sway
- **Файл**: `.config/sway/config`
- **Обои**: `.config/sway/wp.png` (неактуально, берется из wal-choose)
- **Тема**: Автоматически генерируется из pywal
- **Разрешение**: 1366x768 (LVDS-1) (пожалуйста, закомментируйте строки с конфигом дисплея, дабы у вас не было проблем с изображением)

### Waybar
- **Конфигурация**: `.config/waybar/config.jsonc`
- **Стили**: `.config/waybar/style.css`
- **Модули**: CPU, память, диск, батарея, Bluetooth, трей, уведомления
- **Скрипты**: 
  - `keyboard-layout.sh` - отображение раскладки (неактуально, используется встроенная возможность waybar)
  - `bluetooth_off_and_on.sh` - управление Bluetooth
  - `uptime.sh` - время работы системы (убрано в конфиге, можете включить)

### Fish Shell
- **Конфигурация**: `.config/fish/config.fish`
- **Редактор по умолчанию**: Micro
- **Pager**: Most
- **Локаль man**: Русская

#### Алиасы Fish
```fish
alias sudo=doas          # Использовать doas вместо sudo
alias add="doas pacman -S"    # Установить пакет
alias u="doas pacman -Syu"    # Обновить систему
alias purge="doas pacman -Rns" # Удалить пакет
alias q=exit             # Быстрый выход
alias c=clear            # Очистить экран
alias ls=lsd             # Современный ls
alias l="lsd -l"         # Длинный список
alias lah="lsd -lah"     # Все файлы с подробностями
alias nano=micro         # Использовать micro
alias m=micro            # Короткий алиас для micro
alias gcl="git clone --depth 1" # Быстрое клонирование
alias addmus='yt-dlp -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --embed-thumbnail --add-metadata --no-write-info-json --no-write-thumbnail --rm-cache-dir -o "%(title)s.%(ext)s"' # Скачать музыку
```

### Fuzzel (Launcher)
- **Шрифт**: Google Sans Code NF
- **Тема**: Интегрирована с pywal
- **Иконки**: Papirus-Dark
- **Размер**: 16 строк, ширина 50

### Mako (Notifications)
- **Шрифт**: Google Sans Display 12
- **Тема**: Интегрирована с pywal

### Cava (Audio Visualizer)
- **Ширина полос**: 2 символа
- **Расстояние между полосами**: 1 символ
- **Тема**: Настраивается через pywal

### Fastfetch (System Info)
- **Логотип**: Arch Linux (маленький)
- **Цветовая схема**: Интегрирована с pywal
- **Модули**: ОС, CPU, GPU, shell, терминал, WM, цвета

## Система тем (Pywal)

### Смена обоев и тем
```bash
# ВАЖНО: Смена обоев должна производиться ТОЛЬКО через команду wal-choose
wal-choose

# После смены обоев рекомендуется применить темы для всех приложений:
# GTK/Kvantum темы
./pywal16-libadwaita/scripts/apply-theme.sh -s

# Тема Telegram
walogram -s
```

### Применение темы (альтернативные команды)
```bash
# Применить тему из изображения (настоятельно не рекомендуется, используйте wal-choose)
wal -i /path/to/image

# Восстановить последнюю тему
wal -R --cols16
```

### Автоматическая интеграция
Pywal автоматически генерирует цветовые схемы для:
- Sway
- Waybar
- Fuzzel
- Mako
- Cava
- Fish prompt
- GTK & Kvantum тем

### pywal16-libadwaita
Дополнительная интеграция для GTK приложений:
```bash
# Сборка темы Gradience
cd pywal16-libadwaita
make install

# Применение темы
./scripts/apply-theme.sh
```

## Структура файлов

```
.config/
├── sway/
│   ├── config              # Основная конфигурация Sway
│   ├── generate-theme.sh   # Генератор тем для Chrome
│   └── wp.png             # Обои рабочего стола
├── waybar/
│   ├── config.jsonc       # Конфигурация Waybar
│   ├── style.css          # Стили Waybar
│   └── scripts/           # Скрипты для модулей
├── fish/
│   ├── config.fish        # Конфигурация Fish
│   └── functions/         # Функции и промпты
├── fuzzel/
│   └── fuzzel.ini         # Конфигурация лаунчера
├── mako/
│   └── config             # Конфигурация уведомлений
├── cava/
│   └── config             # Конфигурация аудиовизуализатора
├── fastfetch/
│   └── config.jsonc       # Конфигурация системной информации
└── wal/
    └── templates/         # Шаблоны для pywal
```

## Автозапуск

При старте Sway автоматически запускаются:
- XDG Desktop Portal (Wayland/GTK)
- Polkit authentication agent
- Mako (уведомления)
- Pywal (восстановление темы)
- Xwayland satellite
- Sway Alt-Tab GUI

## Дополнительные возможности

### Управление питанием
- Отображение заряда батареи в Waybar
- Автоматическое управление яркостью

### Мультимедиа
- Интеграция с PulseAudio через Waybar
- Аудиовизуализация через Cava

### Сеть
- Отображение статуса Bluetooth
- Управление сетевыми подключениями

## Устранение неполадок

### Проблемы с запуском
1. Убедитесь, что все зависимости установлены
2. Проверьте права доступа к конфигурационным файлам
3. Проверьте логи: `journalctl -u sway`

### Проблемы с темами
1. Переустановите pywal: `yay -S python-pywal16`
2. Очистите кэш: `rm -rf ~/.cache/wal`
3. Примените тему заново: `wal -R`

### Проблемы с клавиатурой
1. Проверьте раскладки: `swaymsg -t get_inputs`
2. Перезагрузите конфигурацию: `Super + Shift + C`

## Кастомизация

### Изменение кейбиндов
Отредактируйте `.config/sway/config` и перезагрузите конфигурацию.

### Добавление новых модулей Waybar
1. Добавьте модуль в `config.jsonc`
2. Создайте стили в `style.css`
3. При необходимости добавьте скрипт в `scripts/`

### Настройка Fish
Добавьте алиасы и функции в `.config/fish/config.fish` или создайте отдельные файлы в `functions/`.

## Полезные команды

```bash
# Информация о системе
fastfetch

# Список окон Sway
swaymsg -t get_tree

# Перезагрузка Waybar
killall waybar && waybar &

# Применение новой темы
wal -i ~/Pictures/wallpaper.jpg (не рекомендуется)

# Очистка кэша Fish
fish -c "history clear"
```

---
title: Туториал - Публикация заметок через Quartz 4 и GitHub Pages
draft: false
tags:
  - tutorial
  - quartz
  - github
  - deployment
---

> [!abstract]+ О туториале
> Пошаговое руководство по публикации заметок Obsidian на сайт через Quartz 4 и GitHub Pages. От установки до автоматического деплоя.

---

# Туториал: Публикация заметок через Quartz 4 и GitHub Pages

## 🎯 Что мы будем делать?

**Цель:** Опубликовать вашу документацию "Система 5542" как красивый веб-сайт, доступный по адресу `https://<ваш-username>.github.io/<название-репозитория>`

**Что получится:**
- ✅ Красивый веб-сайт с вашими заметками
- ✅ Автоматическая публикация при каждом обновлении
- ✅ Поиск по содержимому
- ✅ Граф связей между заметками
- ✅ Темная/светлая тема
- ✅ Бесплатный хостинг на GitHub Pages

**Что потребуется:**
- Node.js (уже должен быть установлен)
- Git (уже установлен)
- Аккаунт на GitHub
- Ваши заметки в Markdown

**Время:** ~30-40 минут на первичную настройку

---

# Шаг 1: Подготовка Quartz проекта

## 1.1. Проверка текущей структуры

У вас уже есть Quartz проект в папке:
```
C:\Users\shram\Desktop\CURSOR\Bridge\quartz\
```

Проверим структуру:

```bash
cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz
dir
```

**Ожидаемая структура:**
```
quartz/
├── content/           # Ваши Markdown файлы (уже есть)
│   └── Системе 5542/  # Ваша документация
├── quartz/            # Код Quartz
├── package.json       # Зависимости Node.js
├── quartz.config.ts   # Конфигурация сайта
└── quartz.layout.ts   # Настройка макета
```

## 1.2. Установка зависимостей (если еще не сделано)

```bash
# Перейти в папку проекта
cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz

# Установить зависимости
npm install
```

**Что происходит:** Устанавливаются все необходимые пакеты для работы Quartz.

## 1.3. Тестовый запуск локально

Проверим, что всё работает:

```bash
# Запустить локальный сервер
npx quartz build --serve
```

**Результат:** Откройте браузер и перейдите на `http://localhost:8080`

Вы должны увидеть свой сайт локально!

> [!tip]+ Остановка сервера
> Нажмите `Ctrl+C` в терминале, чтобы остановить локальный сервер.

---

# Шаг 2: Настройка конфигурации

## 2.1. Редактирование quartz.config.ts

Откройте файл `quartz.config.ts` и настройте основные параметры:

```typescript
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Система 5542 - Бриджевая система торговли",
    enableSPA: true,
    enablePopovers: true,
    analytics: {
      provider: "plausible", // или null если не нужна аналитика
    },
    locale: "ru-RU", // Русский язык
    baseUrl: "<ваш-username>.github.io/<название-репозитория>", // ВАЖНО!
    ignorePatterns: ["private", "templates", ".obsidian"],
    defaultDateType: "created",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Schibsted Grotesk",
        body: "Source Sans Pro",
        code: "IBM Plex Mono",
      },
      colors: {
        lightMode: {
          light: "#faf8f8",
          lightgray: "#e5e5e5",
          gray: "#b8b8b8",
          darkgray: "#4e4e4e",
          dark: "#2b2b2b",
          secondary: "#284b63",
          tertiary: "#84a59d",
          highlight: "rgba(143, 159, 169, 0.15)",
        },
        darkMode: {
          light: "#161618",
          lightgray: "#393639",
          gray: "#646464",
          darkgray: "#d4d4d4",
          dark: "#ebebec",
          secondary: "#7b97aa",
          tertiary: "#84a59d",
          highlight: "rgba(143, 159, 169, 0.15)",
        },
      },
    },
  },
  // ... остальные настройки
}
```

**Важные параметры:**

| Параметр | Описание | Пример |
|----------|----------|--------|
| `pageTitle` | Заголовок сайта | "Система 5542" |
| `baseUrl` | URL вашего сайта | "username.github.io/bridge" |
| `locale` | Язык | "ru-RU" |
| `ignorePatterns` | Игнорируемые папки | [".obsidian", "private"] |

> [!warning]- ВАЖНО про baseUrl
> `baseUrl` должен соответствовать вашему GitHub Pages URL!
> 
> Формат: `<username>.github.io/<repo-name>`
> 
> Например: `shram-bridge.github.io/sistema-5542`

## 2.2. Настройка макета (опционально)

Файл `quartz.layout.ts` определяет расположение элементов на странице:

```typescript
export const defaultContentPageLayout: PageLayout = {
  beforeBody: [
    Component.Breadcrumbs(),
    Component.ArticleTitle(),
    Component.ContentMeta(),
    Component.TagList(),
  ],
  left: [
    Component.PageTitle(),
    Component.MobileOnly(Component.Spacer()),
    Component.Search(),
    Component.Darkmode(),
    Component.DesktopOnly(Component.Explorer()),
  ],
  right: [
    Component.Graph(),
    Component.DesktopOnly(Component.TableOfContents()),
    Component.Backlinks(),
  ],
}
```

**Можете настроить:**
- Какие компоненты показывать
- Где они расположены (left/right/beforeBody/afterBody)

---

# Шаг 3: Создание GitHub репозитория

## 3.1. Создание нового репозитория

**Вариант A: Через веб-интерфейс GitHub**

1. Перейдите на https://github.com
2. Войдите в свой аккаунт
3. Нажмите **"New"** (или зеленая кнопка "New repository")
4. Заполните форму:
   - **Repository name:** `bridge-sistema-5542` (или любое другое название)
   - **Description:** "Система 5542 - Бриджевая система торговли"
   - **Public** или **Private** - выберите по желанию
   - ❌ **НЕ ВКЛЮЧАЙТЕ:** README, .gitignore, license
5. Нажмите **"Create repository"**

**Вариант B: Через GitHub CLI (если установлен)**

```bash
# Создать репозиторий
gh repo create bridge-sistema-5542 --public --description "Система 5542 - Бриджевая система торговли"
```

## 3.2. Копирование URL репозитория

После создания GitHub покажет Quick Setup страницу.

**Скопируйте HTTPS URL:**
```
https://github.com/<ваш-username>/bridge-sistema-5542.git
```

---

# Шаг 4: Инициализация Git в проекте Quartz

## 4.1. Проверка текущего состояния Git

```bash
cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz

# Проверить, инициализирован ли Git
git status
```

**Если Git еще НЕ инициализирован:**
```bash
# Инициализировать Git
git init

# Переключиться на ветку v4 (требование Quartz)
git checkout -b v4
```

**Если Git уже инициализирован:**
```bash
# Проверить текущую ветку
git branch

# Если не на v4, переключиться:
git checkout -b v4
```

## 4.2. Добавление GitHub репозитория как remote

```bash
# Добавить ваш GitHub репозиторий как origin
git remote add origin https://github.com/<ваш-username>/bridge-sistema-5542.git

# Проверить
git remote -v
```

**Ожидаемый результат:**
```
origin  https://github.com/<username>/bridge-sistema-5542.git (fetch)
origin  https://github.com/<username>/bridge-sistema-5542.git (push)
```

## 4.3. Добавление upstream (опционально, для обновлений Quartz)

```bash
# Добавить оригинальный репозиторий Quartz
git remote add upstream https://github.com/jackyzha0/quartz.git

# Проверить
git remote -v
```

---

# Шаг 5: Настройка GitHub Actions для автодеплоя

## 5.1. Создание workflow файла

Создайте файл `.github/workflows/deploy.yml` внутри папки `quartz`:

**Путь:** `C:\Users\shram\Desktop\CURSOR\Bridge\quartz\.github\workflows\deploy.yml`

**Содержимое файла:**

```yaml
name: Deploy Quartz site to GitHub Pages

on:
  push:
    branches:
      - v4

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0 # Fetch all history for git info
      
      - uses: actions/setup-node@v4
        with:
          node-version: 22
      
      - name: Install Dependencies
        run: npm ci
      
      - name: Build Quartz
        run: npx quartz build
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: public

  deploy:
    needs: build
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

**Что делает этот workflow:**
1. ✅ Слушает изменения в ветке `v4`
2. ✅ Устанавливает Node.js
3. ✅ Устанавливает зависимости
4. ✅ Собирает сайт (`npx quartz build`)
5. ✅ Публикует на GitHub Pages

## 5.2. Создание папок и файла через командную строку

```bash
cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz

# Создать папки
mkdir -p .github\workflows

# Затем создайте файл deploy.yml с содержимым выше
# (используйте Notepad, VS Code, или команду echo)
```

---

# Шаг 6: Первая публикация

## 6.1. Добавление файлов в Git

```bash
cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz

# Добавить все файлы
git add .

# Проверить, что будет закоммичено
git status

# Создать первый коммит
git commit -m "Initial commit: Система 5542 - Bridge bidding system documentation"
```

## 6.2. Публикация в GitHub

```bash
# Отправить на GitHub
git push -u origin v4
```

**Что происходит:**
- ✅ Все файлы загружаются в GitHub
- ✅ GitHub Actions автоматически запускает сборку
- ✅ Через 2-3 минуты сайт будет опубликован

## 6.3. Отслеживание процесса сборки

1. Перейдите в ваш репозиторий на GitHub
2. Кликните на вкладку **"Actions"**
3. Вы увидите запущенный workflow **"Deploy Quartz site to GitHub Pages"**
4. Кликните на него, чтобы увидеть прогресс

**Статусы:**
- 🟡 Желтая точка = В процессе
- ✅ Зеленая галочка = Успешно
- ❌ Красный крестик = Ошибка (см. логи)

---

# Шаг 7: Настройка GitHub Pages

## 7.1. Включение GitHub Pages

1. Перейдите в ваш репозиторий на GitHub
2. Кликните на вкладку **"Settings"**
3. В боковом меню найдите **"Pages"**
4. В разделе **"Source"** выберите:
   - **Source:** `GitHub Actions` (не "Deploy from a branch"!)
5. Сохраните

**Скриншот настроек:**
```
Settings → Pages → Source
┌─────────────────────────────────┐
│ Source: [GitHub Actions ▼]     │
└─────────────────────────────────┘
```

## 7.2. Проверка публикации

После успешной сборки (зеленая галочка в Actions):

1. Вернитесь в Settings → Pages
2. Вы увидите сообщение:
   ```
   ✅ Your site is live at https://<username>.github.io/<repo-name>/
   ```
3. Кликните на ссылку → Ваш сайт опубликован! 🎉

---

# Шаг 8: Использование команды sync

## 8.1. Удобная команда для обновлений

Quartz предоставляет команду `sync` для автоматизации:

```bash
npx quartz sync
```

**Что делает команда:**
1. ✅ Делает `git pull` (скачивает изменения с GitHub)
2. ✅ Делает `git add .` (добавляет ваши изменения)
3. ✅ Делает `git commit` (коммитит изменения)
4. ✅ Делает `git push` (отправляет на GitHub)
5. ✅ GitHub Actions автоматически пересобирает сайт

## 8.2. Рабочий процесс обновления контента

**Каждый раз когда вы обновляете заметки:**

```bash
# 1. Перейти в папку Quartz
cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz

# 2. Синхронизировать
npx quartz sync
```

**Готово!** Через 2-3 минуты изменения появятся на сайте.

## 8.3. Опции команды sync

```bash
# Только загрузить (без pull)
npx quartz sync --no-pull

# Указать директорию
npx quartz sync --directory путь/к/папке

# Подробный вывод
npx quartz sync --verbose

# Указать коммит-сообщение
npx quartz sync --commit "Добавлена онтология торговли"
```

---

# Шаг 9: Настройка навигации и компонентов

## 9.1. Основные компоненты Quartz

**Доступные компоненты:**
- `PageTitle()` - Заголовок сайта
- `Search()` - Поиск по содержимому
- `Darkmode()` - Переключатель темной/светлой темы
- `Explorer()` - Дерево файлов
- `Graph()` - Граф связей
- `TableOfContents()` - Оглавление страницы
- `Breadcrumbs()` - Хлебные крошки
- `TagList()` - Список тегов
- `Backlinks()` - Обратные ссылки

## 9.2. Настройка главной страницы

Создайте файл `content/index.md` - это будет главная страница:

```markdown
---
title: Главная - Система 5542
---

# Добро пожаловать в Систему 5542

**Полная документация бриджевой системы торговли**

## 🎯 Начните здесь:

- [[0. О системе|Описание системы]] - Навигация по всей системе
- [[Конвенции|Справочник конвенций]] - 42 конвенции с примерами
- [[Онтология торговли|Онтология]] - Формальное представление знаний

## 📚 Основные разделы:

### Открытия на 1 уровне:
- [[1. Открытие 1♣]]
- [[2. Открытие 1♦]]
- [[3. Открытие 1♥]]
- [[4. Открытие 1♠]]
- [[5. Открытие 1NT]]

### Специальные темы:
- [[Шлемовая торговля]] - Блэквуд, RKCB, кюбиды
- [[Вист]] - Конкурентная торговля
- [[Первый ход (Атака)]] - Что выходить
- [[Сигналы в защите]] - Отношение, количество, преференс

---

*Обновлено: {{date}}*
```

---

# Шаг 10: Оптимизация для русского языка

## 10.1. Настройка поиска

В файле `quartz.config.ts` убедитесь, что поиск настроен правильно:

```typescript
Plugin.FullPageSearch({
  enablePreview: true,
  searchDescriptions: true,
  searchTitles: true,
})
```

## 10.2. Добавление русских шрифтов

Можете использовать Google Fonts с поддержкой кириллицы:

```typescript
typography: {
  header: "Roboto",      // Хорошо для кириллицы
  body: "Open Sans",     // Хорошо для кириллицы
  code: "JetBrains Mono", // Для кода
}
```

---

# Шаг 11: Дополнительные настройки

## 11.1. Добавление favicon

1. Создайте/найдите иконку `favicon.ico` или `favicon.png`
2. Положите в папку `quartz/static/`
3. Quartz автоматически её подхватит

## 11.2. Настройка robots.txt и sitemap

Quartz автоматически генерирует:
- `sitemap.xml` - карта сайта для поисковиков
- `robots.txt` - правила для роботов

Настроить можно в `quartz.config.ts`:

```typescript
plugins: {
  transformers: [
    // ... другие плагины
    Plugin.Description(), // Описания для SEO
  ],
  emitters: [
    Plugin.ContentPage(),
    Plugin.FolderPage(),
    Plugin.TagPage(),
    Plugin.ContentIndex(),
    Plugin.Assets(),
    Plugin.Static(),
    Plugin.NotFoundPage(),
  ],
}
```

## 11.3. Настройка custom domain (опционально)

**Если хотите использовать свой домен (например, `bridge.example.com`):**

### Шаг 1: Создать файл CNAME

Создайте файл `quartz/static/CNAME` с содержимым:
```
bridge.example.com
```

### Шаг 2: Настроить DNS у провайдера

**Для поддомена (subdomain.example.com):**
Создайте CNAME запись:
```
Type: CNAME
Name: bridge (или subdomain)
Value: <username>.github.io
```

**Для apex домена (example.com):**
Создайте A записи:
```
Type: A
Name: @
Value: 185.199.108.153
Value: 185.199.109.153
Value: 185.199.110.153
Value: 185.199.111.153
```

### Шаг 3: Настроить в GitHub

1. Settings → Pages → Custom domain
2. Введите ваш домен: `bridge.example.com`
3. Нажмите Save
4. Включите **"Enforce HTTPS"** (после проверки DNS)

---

# Шаг 12: Рабочий процесс (workflow)

## 12.1. Ежедневная работа с контентом

**Схема работы:**

```
1. Редактируете заметки в Obsidian
   ↓
2. Сохраняете изменения
   ↓
3. Открываете терминал
   ↓
4. cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz
   ↓
5. npx quartz sync
   ↓
6. Ждете 2-3 минуты
   ↓
7. Обновляете сайт в браузере (Ctrl+F5)
   ↓
8. ✅ Изменения опубликованы!
```

## 12.2. Автоматизация через скрипт (опционально)

Создайте файл `sync.bat` в папке Quartz:

```batch
@echo off
echo ========================================
echo Синхронизация Системы 5542 с GitHub
echo ========================================
echo.

cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz

echo [1/3] Проверка изменений...
git status

echo.
echo [2/3] Синхронизация с GitHub...
npx quartz sync

echo.
echo [3/3] Готово!
echo.
echo Сайт будет обновлен через 2-3 минуты.
echo URL: https://<username>.github.io/bridge-sistema-5542/
echo.
pause
```

**Использование:**
Двойной клик на `sync.bat` → автоматическая синхронизация!

## 12.3. Проверка статуса деплоя

**Способ 1: Через GitHub Actions**
1. Откройте ваш репозиторий на GitHub
2. Вкладка **Actions**
3. Смотрите последний запуск

**Способ 2: Через командную строку (с gh CLI)**
```bash
gh run list --limit 5
gh run view <run-id>
```

---

# Шаг 13: Troubleshooting (решение проблем)

## 13.1. Проблема: "Failed to deploy to GitHub Pages"

**Причина:** Нет прав на github-pages environment

**Решение:**
1. Settings → Environments
2. Удалите существующий `github-pages` environment (значок корзины)
3. GitHub Action пересоздаст его автоматически при следующем push

## 13.2. Проблема: "Changes not showing up"

**Возможные причины:**

**A. Забыли запушить:**
```bash
# Проверить
git status

# Если есть uncommitted изменения:
npx quartz sync
```

**B. Кэш браузера:**
- Нажмите `Ctrl + Shift + R` (жесткое обновление)
- Или откройте в режиме инкогнито

**C. GitHub Actions не запустился:**
- Проверьте вкладку Actions на GitHub
- Посмотрите логи, если есть ошибки

## 13.3. Проблема: "404 - Not Found"

**Причина:** Неправильный `baseUrl` в конфигурации

**Решение:**
1. Откройте `quartz.config.ts`
2. Проверьте `baseUrl`:
   ```typescript
   baseUrl: "<username>.github.io/<repo-name>",
   ```
3. Должно совпадать с URL вашего GitHub Pages
4. Пересоберите и запушьте:
   ```bash
   npx quartz sync
   ```

## 13.4. Проблема: "Broken links between notes"

**Причина:** Неправильный формат wiki-links

**Решение:**
Используйте формат:
```markdown
✅ [[Название файла]] - правильно
✅ [[Название файла|Текст ссылки]] - правильно
❌ [[путь/к/файлу.md]] - может не работать
```

## 13.5. Проблема: "Build failed - npm ci error"

**Причина:** Проблемы с зависимостями

**Решение:**
```bash
# Удалить node_modules и package-lock.json
rm -rf node_modules package-lock.json

# Переустановить
npm install

# Попробовать снова
npx quartz sync
```

## 13.6. Проблема: "Images not loading"

**Причина:** Неправильный путь к изображениям

**Решение:**
1. Изображения должны быть в папке `content/` (или подпапках)
2. Используйте относительные пути:
   ```markdown
   ![Описание](./attachments/image.png)
   ```
3. Или абсолютные пути от content:
   ```markdown
   ![Описание](/attachments/image.png)
   ```

---

# Шаг 14: Продвинутые настройки

## 14.1. Настройка плагинов

Файл `quartz.config.ts` содержит секцию плагинов:

```typescript
plugins: {
  transformers: [
    Plugin.FrontMatter(),        // YAML frontmatter
    Plugin.CreatedModifiedDate(),// Даты создания/изменения
    Plugin.SyntaxHighlighting(), // Подсветка кода
    Plugin.ObsidianFlavoredMarkdown(), // Obsidian синтаксис
    Plugin.GitHubFlavoredMarkdown(),   // GitHub Markdown
    Plugin.TableOfContents(),    // Оглавление
    Plugin.CrawlLinks(),         // Поиск ссылок
    Plugin.Description(),        // SEO описания
    Plugin.Latex(),             // LaTeX формулы (если нужно)
  ],
  filters: [
    Plugin.RemoveDrafts(),      // Удалить draft: true
  ],
  emitters: [
    Plugin.AliasRedirects(),    // Перенаправления
    Plugin.ComponentResources(),
    Plugin.ContentPage(),       // Страницы контента
    Plugin.FolderPage(),        // Страницы папок
    Plugin.TagPage(),           // Страницы тегов
    Plugin.ContentIndex(),      // Индекс для поиска
    Plugin.Assets(),            // Статичные файлы
    Plugin.Static(),            // Папка static/
    Plugin.NotFoundPage(),      // 404 страница
  ],
}
```

**Полезные плагины для вашего проекта:**
- ✅ `Plugin.Latex()` - если есть математические формулы
- ✅ `Plugin.Description()` - для SEO
- ✅ `Plugin.TableOfContents()` - оглавление (уже используется)

## 14.2. Настройка игнорируемых файлов

В `quartz.config.ts`:

```typescript
ignorePatterns: [
  "private",           // Папка private/
  "templates",         // Шаблоны
  ".obsidian",         // Конфигурация Obsidian
  "**/*.excalidraw",   // Excalidraw рисунки
  "**/*.canvas",       // Canvas файлы Obsidian
  "**/drafts/**",      // Черновики
],
```

## 14.3. Настройка Graph View

Граф связей между заметками - красивая визуализация!

```typescript
Component.Graph({
  localGraph: {
    drag: true,           // Можно двигать узлы
    zoom: true,           // Можно зумить
    depth: 1,             // Глубина связей (1 уровень)
    scale: 1.1,           // Масштаб
    repelForce: 0.5,      // Сила отталкивания
    centerForce: 0.3,     // Сила центрирования
    linkDistance: 30,     // Расстояние между узлами
    fontSize: 0.6,        // Размер шрифта
    opacityScale: 1,      // Прозрачность
    showTags: true,       // Показывать теги
  },
  globalGraph: {
    drag: true,
    zoom: true,
    depth: -1,            // -1 = все связи
    scale: 0.9,
    repelForce: 0.5,
    centerForce: 0.3,
    linkDistance: 30,
    fontSize: 0.5,
    opacityScale: 1,
    showTags: true,
  },
})
```

---

# Шаг 15: Оптимизация и производительность

## 15.1. Размер сайта

**Проверка размера:**
```bash
# После сборки
npx quartz build

# Проверить размер папки public
dir public
```

**Оптимизация:**
- ✅ Сжимайте изображения (используйте JPG вместо PNG где можно)
- ✅ Удаляйте неиспользуемые файлы из `content/`
- ✅ Используйте `.gitignore` для больших файлов

## 15.2. Скорость загрузки

Quartz автоматически оптимизирует:
- ✅ Минификация CSS и JS
- ✅ Lazy loading изображений
- ✅ Предзагрузка ссылок (при наведении)
- ✅ SPA режим (быстрая навигация без перезагрузки)

## 15.3. SEO оптимизация

**Добавьте в frontmatter каждой заметки:**

```yaml
---
title: Название страницы
description: Краткое описание для поисковиков (150-160 символов)
tags:
  - bridge
  - convention
  - slam
---
```

**Quartz автоматически создаст:**
- `<title>` тег
- `<meta name="description">` тег
- Open Graph теги (для соцсетей)
- Sitemap.xml

---

# Шаг 16: Мониторинг и аналитика (опционально)

## 16.1. Добавление Google Analytics

В `quartz.config.ts`:

```typescript
analytics: {
  provider: "google",
  tagId: "G-XXXXXXXXXX", // Ваш GA ID
}
```

## 16.2. Добавление Plausible Analytics (более приватная альтернатива)

```typescript
analytics: {
  provider: "plausible",
}
```

## 16.3. Отключение аналитики

```typescript
analytics: null,
```

---

# Шаг 17: Резервное копирование

## 17.1. GitHub как резервная копия

Ваши заметки теперь хранятся в двух местах:
- ✅ Локально: `C:\Users\shram\Desktop\CURSOR\Bridge\quartz\content\`
- ✅ GitHub: `https://github.com/<username>/bridge-sistema-5542`

## 17.2. Клонирование на другом компьютере

Если хотите работать с другого компьютера:

```bash
# Клонировать репозиторий
git clone https://github.com/<username>/bridge-sistema-5542.git

# Перейти в папку
cd bridge-sistema-5542

# Установить зависимости
npm install

# Запустить локально
npx quartz build --serve
```

---

# Шаг 18: Чек-лист полной настройки

## ✅ Проверьте всё перед запуском:

- [ ] Node.js установлен (`node --version`)
- [ ] Git установлен (`git --version`)
- [ ] Создан GitHub репозиторий
- [ ] `quartz.config.ts` настроен:
  - [ ] `pageTitle` заполнен
  - [ ] `baseUrl` соответствует GitHub Pages URL
  - [ ] `locale = "ru-RU"`
- [ ] Создан файл `.github/workflows/deploy.yml`
- [ ] Git инициализирован и на ветке `v4`
- [ ] Remote `origin` указывает на ваш GitHub репозиторий
- [ ] GitHub Pages настроены (Source: GitHub Actions)
- [ ] Создан файл `content/index.md` (главная страница)
- [ ] Первый коммит сделан и запушен

---

# Шаг 19: Первый запуск - пошаговая команда

**Выполните команды по порядку:**

```bash
# 1. Перейти в папку Quartz
cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz

# 2. Убедиться, что зависимости установлены
npm install

# 3. Проверить конфигурацию
# (откройте quartz.config.ts и проверьте baseUrl)

# 4. Инициализировать Git (если еще не сделано)
git init
git checkout -b v4

# 5. Добавить remote
git remote add origin https://github.com/<username>/bridge-sistema-5542.git

# 6. Добавить все файлы
git add .

# 7. Первый коммит
git commit -m "Initial commit: Система 5542 Bridge documentation"

# 8. Запушить на GitHub
git push -u origin v4

# 9. Перейти на GitHub и настроить Pages
# (Settings → Pages → Source: GitHub Actions)

# 10. Дождаться сборки (Actions tab)

# 11. Открыть сайт!
# https://<username>.github.io/bridge-sistema-5542/
```

---

# Шаг 20: Полезные команды

## 20.1. Основные команды Quartz

```bash
# Локальный сервер для разработки
npx quartz build --serve

# Только сборка (без сервера)
npx quartz build

# Синхронизация с GitHub
npx quartz sync

# Обновление Quartz до последней версии
npx quartz update

# Создание нового контента
npx quartz create
```

## 20.2. Git команды

```bash
# Проверить статус
git status

# Посмотреть изменения
git diff

# Посмотреть историю
git log --oneline

# Откатить изменения (осторожно!)
git reset --hard HEAD

# Посмотреть удаленные репозитории
git remote -v

# Проверить текущую ветку
git branch
```

## 20.3. Отладка

```bash
# Проверить build процесс
npx quartz build --verbose

# Очистить кэш
rm -rf .quartz-cache
npm clean-install

# Пересоздать public папку
rm -rf public
npx quartz build
```

---

# Шаг 21: Примеры настроек для вашего проекта

## 21.1. Пример quartz.config.ts для "Система 5542"

```typescript
import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

const config: QuartzConfig = {
  configuration: {
    pageTitle: "Система 5542 - Бриджевая система торговли",
    enableSPA: true,
    enablePopovers: true,
    analytics: null,
    locale: "ru-RU",
    baseUrl: "shram.github.io/bridge-5542", // ЗАМЕНИТЕ на ваш URL!
    ignorePatterns: ["private", "templates", ".obsidian"],
    defaultDateType: "created",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Roboto",
        body: "Open Sans",
        code: "JetBrains Mono",
      },
      colors: {
        lightMode: {
          light: "#faf8f8",
          lightgray: "#e5e5e5",
          gray: "#b8b8b8",
          darkgray: "#4e4e4e",
          dark: "#2b2b2b",
          secondary: "#284b63",
          tertiary: "#84a59d",
          highlight: "rgba(143, 159, 169, 0.15)",
        },
        darkMode: {
          light: "#161618",
          lightgray: "#393639",
          gray: "#646464",
          darkgray: "#d4d4d4",
          dark: "#ebebec",
          secondary: "#7b97aa",
          tertiary: "#84a59d",
          highlight: "rgba(143, 159, 169, 0.15)",
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.NotFoundPage(),
    ],
  },
}

export default config
```

## 21.2. Рекомендуемая структура content/

```
content/
├── index.md                    # Главная страница
├── Системе 5542/               # Основная документация
│   ├── 0. О системе.md
│   ├── Конвенции.md
│   ├── Онтология торговли.md
│   ├── 1. Открытие 1♣.md
│   ├── ... (остальные файлы)
│   └── attachments/            # Изображения
│       └── *.png
└── static/                     # Статичные файлы (favicon, etc)
```

---

# Шаг 22: FAQ (Часто задаваемые вопросы)

## Q1: Как часто можно обновлять сайт?

**A:** Без ограничений! GitHub Actions бесплатны для публичных репозиториев (2000 минут/месяц для приватных).

## Q2: Можно ли работать из Obsidian напрямую?

**A:** Да! Просто создайте симлинк или настройте Obsidian vault в папке `content/`:

```bash
# В Obsidian: File → Open folder as vault
# Выберите: C:\Users\shram\Desktop\CURSOR\Bridge\quartz\content\
```

Затем работайте как обычно в Obsidian, а для публикации используйте `npx quartz sync`.

## Q3: Сколько времени занимает деплой?

**A:** Обычно 2-3 минуты от `git push` до появления на сайте.

## Q4: Можно ли использовать приватный репозиторий?

**A:** Да, GitHub Pages работают и с приватными репозиториями (но сам сайт будет публичным).

## Q5: Как добавить пароль на сайт?

**A:** GitHub Pages не поддерживают пароли. Варианты:
- Использовать приватный репозиторий (но сайт все равно публичный)
- Деплоить на Vercel/Netlify с авторизацией
- Использовать собственный сервер

## Q6: Работают ли Obsidian плагины на сайте?

**A:** Нет, Quartz генерирует статичный HTML. Работают только:
- Wiki-links `[[Название]]`
- Callouts `> [!info]`
- Теги `#tag`
- Frontmatter YAML
- Базовый Markdown синтаксис

## Q7: Как обновить Quartz до новой версии?

```bash
# Обновить Quartz
npx quartz update

# Проверить изменения
git status

# Закоммитить обновления
git add .
git commit -m "Update Quartz to latest version"
git push
```

## Q8: Можно ли использовать другой хостинг?

**A:** Да! Quartz поддерживает:
- ✅ GitHub Pages (бесплатно, просто)
- ✅ Cloudflare Pages (бесплатно, быстро)
- ✅ Vercel (бесплатно, много фич)
- ✅ Netlify (бесплатно)
- ✅ Собственный сервер (Nginx, Apache, Caddy)

---

# Шаг 23: Дополнительные ресурсы

## 23.1. Официальная документация

- 📖 **Quartz Documentation:** https://quartz.jzhao.xyz/
- 📖 **GitHub Pages Docs:** https://docs.github.com/pages
- 📖 **Obsidian Help:** https://help.obsidian.md/

## 23.2. Полезные ссылки

- 🎥 **Видео-туториал (English):** https://www.youtube.com/watch?v=6s6DT1yN4dw
- 💡 **Примеры сайтов на Quartz:** https://quartz.jzhao.xyz/showcase
- 🐛 **GitHub Issues:** https://github.com/jackyzha0/quartz/issues

## 23.3. Сообщество

- 💬 **Discord Quartz:** https://discord.gg/cRFFHYye7t
- 💬 **Obsidian Discord:** https://discord.gg/obsidianmd

---

# Шаг 24: Быстрый старт (краткая версия)

**Если знаете что делаете - выполните эти команды:**

```bash
# 1. Установка и настройка
cd C:\Users\shram\Desktop\CURSOR\Bridge\quartz
npm install

# 2. Создать GitHub репозиторий через веб или:
gh repo create bridge-sistema-5542 --public

# 3. Настроить Git
git init
git checkout -b v4
git remote add origin https://github.com/<username>/bridge-sistema-5542.git

# 4. Создать deploy workflow
mkdir -p .github/workflows
# Создайте файл .github/workflows/deploy.yml с конфигом из Шага 5

# 5. Первый деплой
git add .
git commit -m "Initial commit: Sistema 5542"
git push -u origin v4

# 6. Настроить GitHub Pages
# GitHub.com → Settings → Pages → Source: GitHub Actions

# 7. Дождаться сборки (2-3 минуты)
# GitHub.com → Actions → Watch build

# 8. Открыть сайт
# https://<username>.github.io/bridge-sistema-5542/

# 9. Будущие обновления
npx quartz sync
```

---

# Заключение

## ✅ Что вы получили:

1. 🌐 **Публичный веб-сайт** с вашей документацией
2. 🚀 **Автоматический деплой** при каждом обновлении
3. 🔍 **Поиск** по всем заметкам
4. 📊 **Граф связей** между заметками
5. 🎨 **Красивый дизайн** с темной/светлой темой
6. 📱 **Адаптивный** - работает на телефонах
7. ⚡ **Быстрый** - статичный HTML
8. 💰 **Бесплатный** - GitHub Pages free tier

## 🎯 Следующие шаги:

- [ ] Поделиться ссылкой с друзьями/партнерами
- [ ] Добавить больше контента
- [ ] Настроить custom domain (если нужно)
- [ ] Добавить аналитику (если нужно)
- [ ] Оптимизировать SEO (описания, теги)

---

## 📊 Примерный timeline

| Время | Что делаете |
|-------|-------------|
| **0 мин** | Читаете туториал |
| **10 мин** | Создаете GitHub репозиторий |
| **15 мин** | Настраиваете конфигурацию |
| **20 мин** | Создаете deploy.yml |
| **25 мин** | Делаете первый push |
| **28 мин** | Настраиваете GitHub Pages |
| **30 мин** | ✅ Сайт опубликован! |

---

**Готово! Ваша "Система 5542" теперь доступна всему миру!** 🎊

[[0. О системе|← Назад к системе]]

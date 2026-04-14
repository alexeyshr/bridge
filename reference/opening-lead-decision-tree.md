# Opening lead decision tree против мастевых контрактов

Основа: [[defense/opening-leads-practical-summary|practical summary]] и [[sources/winning-suit-contract-leads|Winning Suit Contract Leads]].

Это не абсолютная таблица истинности, а быстрая practical-шпаргалка перед первым ходом.

## Быстрый маршрут

### Шаг 1. Что это за аукцион?

Сначала определи:
- one-suit auction до game? (`1♠–2♠–4♠`, `1♠–3♠–4♠`, `1♥–3♥–4♥`)
- part-score?
- партнёр открывал и показал масть?
- показали ли opponents side suit?
- sacrifice это или нормальный constructive auction?

---

## Decision tree

### 1. Есть ли side-suit singleton?

Если да:
- обычно это lead №1-кандидат;
- особенно против мастевого game contract;
- даже если в другой масти есть красивый honour sequence.

Не спеши с singleton lead, если:
- твои trumps сами уже почти гарантируют защитные взятки;
- singleton lead явно разрушает более сильный и надёжный план.

Практический default:
- singleton есть → обычно начинай именно с него.

---

### 2. Если singleton нет — есть ли хороший doubleton?

Если да, спроси:
- это x-x или spot-card doubleton?
- это A-x / K-x при ожидании сильной руки у партнёра?
- может ли lead создать ruff, promotion или lead through partner’s strength?

Если ответы скорее да:
- doubleton lead очень серьёзный кандидат.

Практический default:
- modest doubleton часто лучше, чем рискованный ход из K-Q-x-x или Q-J-x.

---

### 3. Если нет хорошего short-suit lead — нужен passive или active lead?

Спроси:
- opponents не показали side suit?
- нет ли явного повода атаковать немедленно?
- не выглядит ли honour lead как возможная подарок-взятка?

Если да:
- предпочитай passive spot-card lead из x-x-x или x-x-x-x.

Практический default:
- против one-suit game auction passive lead часто лучше красивого aggressive honour lead.

---

### 4. Есть ли смысл в ace lead ради информации?

Ace lead становится разумным, если:
- ты не видишь хорошего безопасного natural lead;
- хочешь сразу увидеть dummy;
- continuation после сигнала партнёра может оказаться критичным.

Но не делай это автоматически.
Особенно осторожно:
- с ace-doubleton в масти партнёра;
- когда слишком велика вероятность подарить tempo declarer.

Практический default:
- unsupported ace — допустимый practical tool, но не blanket rule.

---

### 5. Пора ли ходить козырем?

Задай себе контрольный вопрос:
- я хочу ходить козырем потому, что это правда лучший контекстный ход,
или просто потому, что не уверен в остальных?

Если второе:
- это плохой знак.

Trump lead чаще оправдан, когда:
- все side suits выглядят неприятно;
- active lead из honour holding опасен;
- responder остановился во второй масти opener’а;
- реально нужно отрезать ruff/discard plan.

Trump lead чаще переоценён, когда:
- one-suit auction до major game;
- у тебя есть singleton;
- у тебя есть playable doubleton;
- passive side-suit lead доступен;
- ты держишь много мелких карт в первой масти declarer.

Практический default:
- trump lead — не default, а запасной план после проверки short-suit и passive options.

---

### 6. Партнёр открывал. Ходить ли в его масть?

Не автоматически.

Сначала проверь:
- есть ли singleton в непоказанной побочной масти?
- не ведёшь ли ты из A-x / A-x-x / K-x-x в масти партнёра?
- не слишком ли длинная у тебя поддержка его масти?

Lead в масть партнёра лучше, когда:
- у тебя singleton в его масти;
- есть ясная причина ожидать у него quality suit;
- альтернативы выглядят хуже.

Lead в масть партнёра хуже, когда:
- это просто рефлекторная привычка;
- у тебя support length, а не directional holding;
- side-suit singleton выглядит острее.

Практический default:
- “partner’s suit” — это strong clue, но не команда.

---

### 7. IMPs или MPs?

Если IMPs:
- можно чаще выбирать attacking lead, если он заметно увеличивает шанс beat the contract.

Если MPs:
- будь осторожнее с lead, который может подарить лишнюю overtrick;
- безопасный средний результат иногда важнее острой попытки посадить.

Практический default:
- не забывай, что лучший lead на IMPs и MPs может различаться.

---

## Ультракороткий алгоритм

Если нужно решить за 5–10 секунд:

1. singleton?
2. если нет — useful doubleton?
3. если нет — passive low card?
4. если нет — informed ace?
5. только потом trump lead.

И отдельно спроси:
- не тянусь ли я автоматически в масть партнёра?

---

## Красные флажки

Остановись и подумай ещё раз, если твой первый импульс:
- “в сомнении хожу козырем”
- “партнёр открывал, значит хожу в его масть”
- “у меня honour, значит надо атаковать этой мастью”

Книга как раз показывает, что эти автоматизмы часто ошибочны.

---

## Мини-версии по типу аукциона

### One-suit game auction
Default priority:
- singleton
- doubleton
- passive side-suit lead
- ace lead
- trump lead в последнюю очередь

### Part-score
Default priority:
- singleton
- active practical lead допустим чаще
- Q-x / A-x поднимаются в цене
- trump lead всё ещё не automatic best

### Partner opened
Default priority:
- singleton in side suit > mechanical lead in partner’s suit
- singleton in partner’s suit тоже силён
- будь осторожен с A-x и A-x-x в partner’s suit

---

## Что смотреть дальше

- [[defense/opening-leads/singleton-leads|Singleton leads]]
- [[defense/opening-leads/doubleton-leads|Doubleton leads]]
- [[defense/opening-leads/trump-leads|Trump leads]]
- [[defense/opening-leads/vs-one-suit-game-auctions|Leads vs one-suit game auctions]]
- [[defense/opening-leads/vs-slams|Leads vs slams]]

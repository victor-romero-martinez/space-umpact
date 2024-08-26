# Manual de Space Umpact

Estructura del directorio
```text
.
├── assets
│   ├── fonts
│   ├── icons
│   ├── music
│   └── sfx
├── control
│   └── theme
├── entities
├── global
├── levels
│   ├── level_1
│   ├── level_2
│   └── level_3
├── scenes
│   ├── enemies
│   ├── music
│   ├── sfx
│   └── utilities
├── scripts
│   ├── control
│   ├── enemy
│   ├── player
│   ├── state
│   └── utils
├── temp
└── test
```

## Pasos para crear un nivel

#### Instanciar la escena *level*.

- Presione <kbd>Ctrl+Shift+A</kbd> y seleccione `res://entities/level.tscn` luego guardar en su respectiva carpeta `res://scenes/level_numero.tscn`.

> Notaras que ya están instaciado con algunos componentes.

 ![Vista del Nodo](./assets/docs/Screenshot-from-2024-08-25 14-28-21.png)

#### Crear un  elemento *BG*.

1. Crear un **TileMap** y asignarle el script `res://scripts/utils/map_chunk.gd` posteriormente guárdalo en `res://levels/level_numero/nombre.tscn`.
2. Luego de tener al menos dos *TileMap* desde ahora llamado <mark>MapChunk</mark>, en la escena del nivel, instanciar como hijo de <u style="color:#f989c7">BackgroundManager</u>.
3. Posteriormente haga clic sobre <u style="color:#f989c7">BackgroundManager</u> y agregue los <mark>MapChunk</mark> al array de **List Map** en el inspector.

> <span style='color: #ffcc32'>⚠️ **IMPORTANTE:** Escalar 2x el TileMap.</span>

#### Agregando [enemigos](#crear-un-enemigo 'Guía para hacer un enemigo')

- Instancia `res://scenes/music/game_music.tscn` y `res://scenes/music/boss_music.tscn` como hijo de <u style="color:#f989c7">EnemyManager</u>.
- Haga clic en <u style="color:#f989c7">EnemyManager</u> y dirigirse al inspector luego agregue en el array de *Game Music* los elementos.

#### Agregando un **Enemy Chunk**

- Presione <kbd>Ctrl+Shift+A</kbd> y seleccione `res://entities/enemy_chunk.tscn`, luego guárdalo en `res://levels/level_numero/enemy_chunk_numero.tscn`.
- Empiece a instanciar a los [enemigos](#crear-un-enemigo 'Guía para hacer un enemigo').

> <span style='color: #92cff4'>📑 NOTA: Aquí configurar el [State machine](#state-machine 'Guía para hacer un FSM') individualmente si lo requiere.</span>

#### Asignar un State {#set-state-machine}

Haga clic en cualquier enemigo y dirigase al inspector, busque la propieda **State**, ahí se asignaran los *estados*. Antes de empezar comienze instaciando el nodo <u style="color:#f989c7">EnemyStateMachine</u>.

Para este ejemplo se usara un estado simple de disparo.

> <span style='color: #ffcc32'>⚠️ **IMPORTANTE:** Marcar *Can Shoot* ☑️ on.</span>

- Haga clic sobre <u style="color:#f989c7">EnemyStateMachine</u> y presione <kbd>Ctrl+A</kbd> para instanciar los siguientes nodos:
	- <u style="color:#f989c7">EnemyAttack</u>
	- <u style="color:#f989c7">EnemyShots</u>

![Vista del nodo](./assets/docs/Screenshot-from-2024-08-26 12-29-33.png)

Ahora toca conectar los *states*

- En el *enemy* asignar **FSM** a <u style="color:#f989c7">EnemyStateMachine</u>.
- En <u style="color:#f989c7">EnemyStateMachine</u> su propiedad **State** asignar un estado que sera el inicial.


## Pasos para crear un Enemigo {#crear-un-enemigo}

1. Presione <kbd>Ctrl+Shift+A</kbd> y seleccione `res://entities/actors.tscn` y guardalo en `res://scenes/enemies/enemigo_numero.tscn`.
2. Configure el sprite y las colisiones.
3. Adjunte el script `res://scripts/enemy/enemy.gd`.
	- Configure las propiedades en el inspector.
	- Haga clic en *Explotion Scene* y seleccione `res://scenes/utils/explotion_scene.tscn`.
4. Presione <kbd>Ctrl+A</kbd> y busca los siguientes componentes:
	- <u style="color:#f989c7">EnemyHitBox</u>
	- <u style="color:#f989c7">EnemyHealthBox</u>
5. Duplique la colision dos veces y arrastre una para cada componente.
6. Haga clic en <u style="color:#f989c7">EnemyHitBox</u> y en el inspector configure su *collision* de la siguiente manera:
	- **Layer** sin asignar.
	- **Mask** asignar a la capa de <mark>player</mark>.
7. Haga clic en <u style="color:#f989c7">EnemyHealthBox</u> y en el inspector configure su *collision* de la siguiente manera:
	- **Layer** asigna a la capa de <mark>enemy</mark>.
	- **Mask** sin asignar.

8. Adicionalmente en <u style="color:#f989c7">EnemyHealthBox</u> instancia la escena `res://scenes/sfx/hit_sfx.tscn` y asignarlo en el inspector a **Hit Sound**.


> <span style='color: #ffcc32'>⚠️ **IMPORTANTE:** Escalar 2x el sprite.</span>

> <span style='color: rgb(88, 191, 212)'>🛈  **INFO:** No configure aquí el [State](#set-state-machine 'Guía para hacer un FSM').</span>





![Extendable Scene Transitions Icon](https://raw.githubusercontent.com/bjorvack/godot-extendable-scene-transitions/refs/heads/main/icon.png)

# Extendable Scene Transitions
An extensible and customizable scene loader for Godot projects.

## 📦 Installation
1. Download the latest release from [GitHub Releases](https://github.com/bjorvack/godot-extendable-scene-transitions/releases/latest).
2. Unpack the addon into `res://addons/`.
3. Enable the plugin in **Project > Project Settings > Plugins**.

## ⚙️ Configuration
After enabling the addon, new **Scene Manager** settings will appear in **Project Settings**.  
Here you can set the **Initial Scene** to load when your project starts.

## 🚀 Using Transitions
To load a new scene, call:

```gdscript
SceneManager.load_scene(PATH_TO_SCENE, TRANSITION_DATA_RESOURCE)
```

- If no `TRANSITION_DATA_RESOURCE` is provided, the scene will load immediately.  
  _(Recommended only for small scenes without visible transitions.)_
- If a `TRANSITION_DATA_RESOURCE` is provided:
  - The `play_out()` method of the transition is called.
  - The new scene is loaded.
  - The `play_in()` method of the transition is triggered after loading.

## 🎨 Creating Custom Transitions
Creating a custom transition involves two steps:

1. **Create a new scene** with a script that extends `SceneTransition`.  
   👉 [Example script](https://github.com/bjorvack/godot-extendable-scene-transitions/blob/main/scripts/fade_screen_transition.gd)

2. **Create a `SceneTransitionData` resource** that references your transition scene.  
   👉 [Example resource](https://github.com/bjorvack/godot-extendable-scene-transitions/blob/main/data/fade.tres)

---

## 📖 Example Usage

```gdscript
var transition_data = load("res://addons/your_addon/data/fade.tres")
SceneManager.load_scene("res://scenes/next_scene.tscn", transition_data)
```

---

## 📄 License
MIT — see [LICENSE.md](https://raw.githubusercontent.com/bjorvack/godot-extendable-scene-transitions/refs/heads/main/LICENSE.md) for details.

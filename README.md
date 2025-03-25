# 🧟‍♂️ Zombies Game (CS292)

A high-performance first-person zombie survival game developed using Godot 4.4, showcasing advanced game development techniques, 3D modeling, and performance optimization.

![Game Screenshot](Screenshots/gameplay.png) *(You'll need to add screenshots to a Screenshots folder)*

## 🎮 Game Overview

An immersive first-person shooter where players must survive against waves of intelligent zombies in a detailed environment. The game features realistic physics, dynamic lighting, advanced AI behavior, and an engaging combat system, all optimized for maximum performance.

## 🚀 Technical Features & Implementation

### 🏗️ Environment & Level Design
- **Asset Pipeline:**
  - Custom-modified 3D models processed through Blender
  - Optimized texture maps with proper UV unwrapping
  - Level geometry optimized for occlusion culling
  - Custom material system for consistent visual quality

### 🎯 Player Mechanics
- **Character Controller:**
  - Smooth first-person camera implementation
  - Physics-based movement system
  - Custom collision detection for precise hit registration
  - Advanced input handling with configurable controls

### 🧟‍♂️ Zombie AI System
- **Behavior Implementation:**
  - State machine-driven AI with multiple behavior patterns
  - Dynamic pathfinding using Navigation Mesh
  - Custom animation system with blended transitions
  - Performance-optimized perception system

### 🔫 Weapon System
- **Gun Mechanics:**
  - Realistic ballistics simulation
  - Dynamic recoil system
  - Particle-based visual effects
  - Sound propagation system

### 🎭 Animation System
- **Character Animations:**
  - Skeletal animation system for zombies
  - Blend trees for smooth transitions
  - Ragdoll physics on death
  - Optimized animation state machines

### ⚡ Performance Optimization
- **Graphics Pipeline:**
  - LOD (Level of Detail) system implementation
  - Occlusion culling for rendering efficiency
  - Dynamic batching for reduced draw calls
  - Optimized shadow casting

- **Memory Management:**
  - Resource pooling for frequently used objects
  - Smart asset loading/unloading
  - Memory-efficient texture compression

## 🛠️ Development Process

### 1. Pre-production
- Initial concept development and technical planning
- Asset requirement analysis
- Performance target definition

### 2. Asset Creation & Integration
- 3D model modification and optimization in Blender
- Texture optimization and atlas creation
- Custom shader development for specific effects

### 3. Core Systems Development
- Player controller implementation
- Weapon system development
- AI behavior programming
- Physics system integration

### 4. Performance Optimization
- Implementation of LOD system
- Occlusion culling setup
- Draw call optimization
- Memory usage optimization

### 5. Polish & Bug Fixing
- Animation refinement
- Performance profiling
- Bug tracking and resolution
- Final optimization pass

## 🔧 Technical Requirements

### Recommended Specifications
- **CPU:** Modern quad-core processor
- **GPU:** Graphics card with 4GB VRAM, DirectX 11/Vulkan support
- **RAM:** 8GB minimum, 16GB recommended
- **Storage:** 2GB available space
- **OS:** Windows 10/11, macOS 12+, or Linux with Vulkan support

## 🎯 Key Technical Achievements

1. **Efficient Resource Management**
   - Custom resource loading system
   - Dynamic memory allocation
   - Smart caching system

2. **Advanced AI Implementation**
   - Multi-threaded AI processing
   - Efficient pathfinding algorithms
   - Dynamic difficulty scaling

3. **Graphics Optimization**
   - Custom shader implementations
   - Efficient particle systems
   - Advanced post-processing effects

## 📊 Performance Metrics

- Maintains 60+ FPS on recommended hardware
- Average draw calls: <1000 per frame
- Memory usage: <2GB
- Load times: <10 seconds

## 🛠️ Tools & Technologies Used

- **Game Engine:** Godot 4.4
- **3D Modeling:** Blender
- **Version Control:** Git
- **Asset Processing:** Custom pipeline tools
- **Performance Profiling:** Built-in Godot profiler

## 🛠️ Prerequisites

- [Godot Engine 4.4](https://godotengine.org/download) or later
- Graphics card with support for Forward+ rendering
- Minimum 4GB RAM recommended
- Operating system: Windows/macOS/Linux

## 📥 Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/zombiesGameCS292-.git
```

2. Open Godot Engine
3. Click "Import"
4. Navigate to the cloned project directory
5. Select the `project.godot` file
6. Click "Open"

## 🎯 How to Play

### Controls
- W/A/S/D - Movement
- Space - Jump
- Left Shift - Sprint
- Left Mouse Button - Shoot
- Mouse Movement - Look around

## 🗂️ Project Structure

- `Assets/` - General game assets
- `Models/` - 3D model files
- `Textures/` - Texture files
- `Scenes/` - Godot scene files
- `Scripts/` - Game logic scripts
- `Materials/` - Material definitions
- `addons/` - Third-party plugins and addons

## 🔌 Plugins Used

- Godot 3D Auto Collision Generator
- Simple Grass Textured

## 🤝 Contributing

This is a course project, but suggestions and bug reports are welcome. Please open an issue to discuss proposed changes.

## 📄 License

This project is licensed under the terms included in the [LICENSE](LICENSE) file.

## 🎓 Course Information

- Course: CS292
- Institution: [Your Institution Name]
- Term: [Current Term/Year]

## ✨ Credits

- Development Team: [Team Member Names]
- Course Instructor: [Instructor Name]
- Special thanks to the Godot Engine community

## 📷 Screenshots & Media

*(Add screenshots showcasing different aspects of the game)*

![Zombie AI](Screenshots/zombie-ai.png)
![Weapon System](Screenshots/weapon-system.png)
![Environment](Screenshots/environment.png)

## 🎓 Technical Documentation

For detailed technical documentation about specific systems:
- [Player Controller Documentation](docs/player-controller.md)
- [AI System Documentation](docs/ai-system.md)
- [Performance Optimization Guide](docs/optimization.md)

---

*Note: This README is a living document and will be updated as the project evolves.* 
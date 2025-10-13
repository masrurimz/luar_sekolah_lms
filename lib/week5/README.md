# Week 5: Navigation, Routing & Animations

## 📚 Overview

Week 5 berfokus pada **Navigation, Routing, dan Animations** - pembelajaran mendalam tentang cara navigasi antar screen, implementasi routing patterns, dan membuat aplikasi lebih hidup dengan animations yang smooth dan professional.

## 🎯 Learning Objectives

- ✅ Memahami Flutter Navigation system
- ✅ Implementasi named routes dan navigation patterns
- ✅ Membuat custom page transitions
- ✅ Master implicit dan explicit animations
- ✅ Implementasi Hero animations untuk shared elements
- ✅ Membuat interactive UI dengan animations
- ✅ Professional navigation patterns (Drawer, Bottom Nav, Tabs)

## 📁 File Structure

```
lib/week5/
├── concepts/                                # Teaching materials
│   ├── 01_navigation_basics.dart           # Push, pop, named routes
│   ├── 02_navigator_widget.dart            # Navigator 2.0 concepts
│   ├── 03_named_routes.dart                # Route management
│   ├── 04_drawer_navigation.dart           # Drawer pattern
│   ├── 05_bottom_navigation.dart           # Bottom navigation bar
│   ├── 06_animation_basics.dart            # Animation fundamentals
│   ├── 07_implicit_animations.dart         # AnimatedContainer, etc
│   ├── 08_explicit_animations.dart         # AnimationController
│   └── 09_hero_page_transitions.dart       # Hero & custom transitions
│
├── widgets/                                 # Reusable components
│   ├── animated_card.dart                   # Interactive card widget
│   └── custom_page_route.dart               # Custom transitions
│
└── screens/                                 # Demo & task screens
    ├── navigation_demo_screen.dart          # Navigation examples
    ├── animation_demo_screen.dart           # Animation examples
    └── weekly_task_screen.dart              # Weekly task implementation
```

## 🧩 Key Components

### 1. AnimatedCard Widget (`widgets/animated_card.dart`)

Reusable animated card component dengan hover, tap, dan initialization effects:

```dart
// Basic usage
AnimatedCard(
  child: ListTile(title: Text('Hello')),
  onTap: () => print('Tapped'),
)

// With custom styling
AnimatedCard(
  color: Colors.blue.shade50,
  elevation: 4,
  hoverScale: 1.1,
  animateOnInit: true,
  delay: Duration(milliseconds: 200),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Custom Card'),
  ),
)

// Grid with staggered animation
GridView.builder(
  itemBuilder: (context, index) {
    return AnimatedCard(
      animateOnInit: true,
      delay: Duration(milliseconds: index * 100),
      onTap: () => Navigator.push(context, /* details */),
      child: Column(children: [...]),
    );
  },
)
```

**Features:**
- 🎨 Hover effect dengan scale & shadow changes
- 👆 Tap effect dengan visual feedback
- ⏱️ Optional fade-in on initialization
- 🎯 Configurable delay untuk staggered animations
- 📦 Material Design 3 compliant
- 🔧 Fully customizable appearance

### 2. CustomPageRoute Utilities (`widgets/custom_page_route.dart`)

Ready-to-use page transition animations:

```dart
// Fade transition
Navigator.push(
  context,
  FadePageRoute(page: DetailScreen()),
);

// Slide from specific direction
Navigator.push(
  context,
  SlidePageRoute(
    page: ProfileScreen(),
    direction: SlideDirection.left,
    duration: Duration(milliseconds: 300),
  ),
);

// Combined slide + fade
Navigator.push(
  context,
  SlideAndFadePageRoute(
    page: SettingsScreen(),
    curve: Curves.easeInOut,
  ),
);

// Using utility helpers
Navigator.push(context, CustomTransitions.fade(ProfileScreen()));
Navigator.push(context, CustomTransitions.slideLeft(SettingsScreen()));
Navigator.push(context, CustomTransitions.scale(DetailScreen()));
```

**Available Transitions:**
- 🎬 **FadePageRoute** - Simple opacity animation
- 📱 **SlidePageRoute** - Slide from left/right/up/down
- 🔍 **ScalePageRoute** - Zoom in/out effect
- 🌟 **SlideAndFadePageRoute** - Combined transition
- 🎭 **RotationPageRoute** - Rotation effect (bonus)

### 3. Teaching Concepts

#### Concept 1: Navigation Basics
- `Navigator.push()` dan `Navigator.pop()`
- Passing data between screens
- MaterialPageRoute basics
- Navigation stack management
- Return values from navigation

#### Concept 2: Navigator Widget
- Navigator 2.0 concepts
- Declarative routing
- Deep linking basics
- Navigation state management
- RouterDelegate patterns

#### Concept 3: Named Routes
- Route registration di MaterialApp
- `Navigator.pushNamed()` usage
- Route arguments
- onGenerateRoute for dynamic routing
- Route guards & middleware

#### Concept 4: Drawer Navigation
- Drawer widget implementation
- Menu structure
- Navigation from drawer
- Drawer header customization
- Mobile-first navigation pattern

#### Concept 5: Bottom Navigation
- BottomNavigationBar widget
- Managing selected index
- Screen switching patterns
- Persistent state across tabs
- Badge notifications

#### Concept 6: Animation Basics
- Animation fundamentals
- Tween and AnimationController
- Animation lifecycle
- Curves for natural motion
- Performance considerations

#### Concept 7: Implicit Animations
- AnimatedContainer
- AnimatedOpacity
- AnimatedAlign, AnimatedPadding
- TweenAnimationBuilder
- When to use implicit animations

#### Concept 8: Explicit Animations
- AnimationController
- Tween animations
- CurvedAnimation
- AnimatedBuilder
- Multiple animations coordination

#### Concept 9: Hero & Page Transitions
- Hero widget for shared elements
- Hero tag matching
- PageRouteBuilder for custom transitions
- SlideTransition, FadeTransition
- Combined transition effects

## 📋 Weekly Task: Animated Feature App

**File:** `screens/weekly_task_screen.dart`

### Requirements

✅ **Menu Screen:**
- Animated navigation cards
- Staggered entrance animations
- Hover effects on cards
- Custom page transitions

✅ **Login Form:**
- Form validation with Week 4 validators
- Animated text fields
- Focus animations
- Shake effect on validation error
- Loading and success animations

✅ **Profile Screen:**
- Hero image transition
- Profile stats with animations
- Staggered list animations
- Tap to fullscreen image
- SliverAppBar with animations

✅ **Settings Screen:**
- Animated toggle switches
- Slider with visual feedback
- Setting cards entrance animations
- Visual state changes

✅ **Dashboard Screen:**
- Welcome card with gradient
- Animated stats grid
- Activity chart with bar animations
- Recent activity list
- Bottom navigation integration

### Implementation Highlights

```dart
// Hero Animation
Hero(
  tag: 'profile-image',
  child: Container(/* avatar */),
)

// Custom Page Transition
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) => page,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  },
)

// TweenAnimationBuilder for entrance
TweenAnimationBuilder<double>(
  tween: Tween(begin: 0.0, end: 1.0),
  duration: Duration(milliseconds: 600),
  curve: Curves.easeOutCubic,
  builder: (context, value, child) {
    return Transform.translate(
      offset: Offset(0, (1 - value) * 50),
      child: Opacity(opacity: value, child: child),
    );
  },
)

// AnimatedContainer for interaction
AnimatedContainer(
  duration: Duration(milliseconds: 200),
  transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        blurRadius: _isHovered ? 20 : 12,
        offset: Offset(0, _isHovered ? 12 : 6),
      ),
    ],
  ),
)
```

## 🎓 Key Learnings

### 1. Navigation Patterns

**Basic Navigation:**
- **Push/Pop** adalah fundamental navigation
- **MaterialPageRoute** untuk platform-native transitions
- **Navigator.pop()** dapat return values
- Stack-based navigation model

**Named Routes:**
- Centralized route management
- Easier deep linking
- Better code organization
- Type-safe dengan route constants

**Navigation Patterns:**
- **Drawer** untuk hierarchical menus
- **Bottom Navigation** untuk top-level destinations
- **Tabs** untuk related content
- Choose based on app structure

### 2. Animation Strategy

**Implicit Animations:**
- Easy to use, automatic animation
- AnimatedContainer, AnimatedOpacity
- Best untuk simple property changes
- No controller management needed

**Explicit Animations:**
- Full control over animation
- AnimationController required
- Complex animations possible
- Manual lifecycle management

**When to Use:**
- **Implicit**: Simple UI state changes
- **Explicit**: Complex, coordinated animations
- **TweenAnimationBuilder**: One-off animations
- **Hero**: Shared element transitions

### 3. UX Best Practices

**Animation Timing:**
- **100-300ms** untuk micro-interactions
- **300-500ms** untuk page transitions
- **500-800ms** untuk entrance animations
- Avoid animations > 1 second

**Animation Curves:**
- **easeInOut** untuk smooth natural motion
- **easeOut** untuk entrance animations
- **easeIn** untuk exit animations
- **elasticOut** untuk playful bounces

**Performance:**
- Use const constructors where possible
- Dispose AnimationControllers
- Avoid rebuilding entire tree
- Use RepaintBoundary untuk complex animations

### 4. Professional Patterns

**Staggered Animations:**
```dart
Duration(milliseconds: 600 + (index * 100))
```
Creates waterfall effect untuk lists

**Loading States:**
Always provide visual feedback during async operations

**Feedback Animations:**
- Success: Scale up with bounce
- Error: Shake with red color
- Loading: Circular progress

**Hero Animations:**
- Match tags exactly
- Works with any widget
- Automatic transition
- Great untuk image galleries

## 🚀 How to Use

### Running Concept Demos

```dart
// In your main.dart or navigation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => NavigationBasicsDemo(),
  ),
);

// Or run animation concepts
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ImplicitAnimationsDemo(),
  ),
);
```

### Using AnimatedCard in Your Project

```dart
import 'package:luar_sekolah_lms/week5/widgets/animated_card.dart';

// Simple card
AnimatedCard(
  onTap: () => print('Tapped'),
  child: ListTile(
    title: Text('Card Title'),
    subtitle: Text('Card Subtitle'),
  ),
)

// Grid with staggered animations
GridView.builder(
  itemBuilder: (context, index) {
    return AnimatedCard(
      animateOnInit: true,
      delay: Duration(milliseconds: index * 100),
      onTap: () => _navigateToDetail(index),
      child: _buildCardContent(index),
    );
  },
)
```

### Using CustomPageRoute

```dart
import 'package:luar_sekolah_lms/week5/widgets/custom_page_route.dart';

// Using specific transition classes
Navigator.push(
  context,
  FadePageRoute(page: NextScreen()),
);

Navigator.push(
  context,
  SlidePageRoute(
    page: NextScreen(),
    direction: SlideDirection.up,
  ),
);

// Using utility helpers (cleaner)
Navigator.push(
  context,
  CustomTransitions.fade(NextScreen()),
);

Navigator.push(
  context,
  CustomTransitions.slideLeft(NextScreen()),
);
```

### Implementing Hero Transitions

```dart
// Source screen
Hero(
  tag: 'unique-tag-123',
  child: Image.network('https://...'),
)

// Destination screen
Hero(
  tag: 'unique-tag-123', // Must match!
  child: Image.network('https://...'),
)

// Navigation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailScreen(),
  ),
);
```

## 📝 Practice Exercises

### Beginner
1. Create simple multi-screen app dengan push/pop navigation
2. Implement named routes dengan 5 screens
3. Add bottom navigation dengan 3 tabs
4. Create fade transition antar screens

### Intermediate
5. Build drawer navigation dengan hierarchical menu
6. Implement Hero animation untuk image gallery
7. Create custom page transition dengan slide + scale
8. Build form dengan animated validation feedback

### Advanced
9. Implement complex staggered list animations
10. Create coordinated multi-element animations
11. Build animated chart dengan bars growing
12. Implement navigation dengan deep linking support

## 🔗 Dependencies

Tidak ada dependencies tambahan untuk Week 5. Semua fitur menggunakan Flutter built-in widgets dan APIs.

```yaml
# No additional dependencies needed
# Using only Flutter SDK:
# - Navigator
# - Animation APIs
# - Material widgets
```

## 📚 References

- [Flutter Navigation Documentation](https://docs.flutter.dev/cookbook/navigation)
- [Navigator 2.0 Guide](https://docs.flutter.dev/development/ui/navigation)
- [Animation Documentation](https://docs.flutter.dev/development/ui/animations)
- [Hero Animations Tutorial](https://docs.flutter.dev/development/ui/animations/hero-animations)
- [Implicit Animations Codelab](https://docs.flutter.dev/codelabs/implicit-animations)
- [Material Motion System](https://material.io/design/motion)

## ✅ Checklist

Before moving to Week 6:

- [ ] Understand Navigator.push() dan Navigator.pop()
- [ ] Can implement named routes
- [ ] Know when to use Drawer vs Bottom Navigation
- [ ] Understand implicit vs explicit animations
- [ ] Can implement Hero animations
- [ ] Created custom page transitions
- [ ] Completed weekly task (weekly_task_screen.dart)
- [ ] Master animation timing and curves
- [ ] Understand animation performance best practices

---

**Next Week:** Week 6 - State Management & Architecture

Happy Learning! 🚀

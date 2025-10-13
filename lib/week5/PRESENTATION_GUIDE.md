# Week 5: Navigation, Routing & Animations

## 📖 Presentation & Teaching Guide

---

## 🎯 Overview

This guide helps instructors present Week 5 materials effectively. Week 5 focuses on **Navigation, Routing, and Animations** - essential skills for creating professional multi-screen Flutter applications.

**Duration:** 2-3 sessions (2-3 hours each)
**Prerequisite:** Week 3 (Widgets) & Week 4 (Forms)
**Learning Style:** Progressive, hands-on, interactive demos

---

## 📋 Table of Contents

1. [Teaching Sequence](#teaching-sequence)
2. [Session Plans](#session-plans)
3. [How to Present Each Component](#how-to-present-each-component)
4. [Live Demo Tips](#live-demo-tips)
5. [Student Learning Path](#student-learning-path)
6. [Assessment Criteria](#assessment-criteria)
7. [Common Questions & Answers](#common-questions--answers)
8. [Troubleshooting](#troubleshooting)

---

## 🎓 Teaching Sequence

### Recommended 3-Session Structure

#### **Session 1: Navigation Fundamentals (2-3 hours)**

- Navigation Basics (30 min)
- Navigator Widget (45 min)
- Named Routes (30 min)
- Drawer Navigation (30 min)
- Bottom Navigation (30 min)

#### **Session 2: Animation Fundamentals (2-3 hours)**

- Animation Basics (45 min)
- Implicit Animations (45 min)
- Explicit Animations (60 min)
- Practice exercises (30 min)

#### **Session 3: Advanced Topics & Task (2-3 hours)**

- Hero Animations (45 min)
- Custom Page Transitions (45 min)
- Combined Demos (30 min)
- Weekly Task Introduction (30 min)
- Guided practice (30 min)

---

## 📚 Session Plans

### Session 1: Navigation Fundamentals

#### Opening (15 min)

```
1. Show completed weekly task demo
2. Explain real-world navigation examples (social media apps)
3. Overview of navigation patterns
```

#### Main Content

**1. Navigation Basics (30 min)**

```dart
// Navigate to: /week5/navigation-basics

📍 What to Show:
- Stack model visualization (push/pop concept)
- Navigation lifecycle diagram
- Key terminology cards
- Interactive push/pop demo

💡 Teaching Tips:
- Use physical stack metaphor (deck of cards)
- Draw stack on whiteboard
- Emphasize FILO (First In, Last Out)

🎯 Learning Check:
- Ask: "What happens when you push 3 screens then pop once?"
- Have students diagram stack states
```

**2. Navigator Widget (45 min)**

```dart
// Navigate to: /week5/navigator

📍 What to Show:
- Simple push/pop example
- Passing data TO screen (constructor)
- Returning data FROM screen (await result)
- Navigation chain (A → B → C)

💡 Teaching Tips:
- Live code the first example from scratch
- Show console.log output for data passing
- Emphasize async/await for return values

🎯 Hands-on Exercise:
Create 2 screens with data passing
Time: 15 minutes
```

**3. Named Routes (30 min)**

```dart
// Navigate to: /week5/named-routes

📍 What to Show:
- Named vs direct routes comparison
- Route definition in MaterialApp
- Passing arguments with RouteSettings
- onGenerateRoute for dynamic routing

💡 Teaching Tips:
- Show main.dart routes section
- Explain when to use each approach
- Discuss scalability benefits

🎯 Discussion:
"When would you use named routes vs direct routes?"
```

**4. Drawer Navigation (30 min)**

```dart
// Navigate to: /week5/drawer

📍 What to Show:
- Drawer structure
- DrawerHeader vs UserAccountsDrawerHeader
- Navigation from drawer items
- Current route highlighting

💡 Teaching Tips:
- Show real app examples (Gmail, Drive)
- Demonstrate swipe gesture
- Emphasize closing drawer after navigation

🎯 Live Demo:
Add drawer to existing app together
```

**5. Bottom Navigation (30 min)**

```dart
// Navigate to: /week5/bottom-nav

📍 What to Show:
- BottomNavigationBar setup
- Tab switching logic
- State preservation (IndexedStack)
- Badge support

💡 Teaching Tips:
- Compare with drawer (when to use each)
- Show Instagram/Twitter examples
- Explain currentIndex state management

🎯 Exercise:
Create 4-tab bottom navigation
```

#### Closing Session 1 (15 min)

```
1. Recap: 5 navigation patterns learned
2. Q&A session
3. Preview Session 2 (animations)
4. Homework: Create app with drawer + bottom nav
```

---

### Session 2: Animation Fundamentals

#### Opening (10 min)

```
1. Review Session 1 homework
2. Show animation examples (smooth vs no animation)
3. Explain why animations matter (UX)
```

#### Main Content

**1. Animation Basics (45 min)**

```dart
// Navigate to: /week5/animation-basics

📍 What to Show:
- Animation vs Transition explanation
- Animation principles (timing, easing, duration)
- Curves demonstration (visual comparison)
- Animation lifecycle state machine

💡 Teaching Tips:
- Use video examples (60fps vs 30fps)
- Show curve graphs visually
- Demonstrate with sliders (duration changes)
- Emphasize "less is more" principle

🎯 Interactive Demo:
Change duration and curves live
Let students feel the difference
```

**2. Implicit Animations (45 min)**

```dart
// Navigate to: /week5/implicit-animations

📍 What to Show:
- AnimatedContainer (size, color, padding)
- AnimatedOpacity (fade effects)
- AnimatedAlign (position)
- TweenAnimationBuilder (custom)

💡 Teaching Tips:
- Start with simplest (AnimatedOpacity)
- Build complexity gradually
- Emphasize "automatic" animation
- Show before/after setState

🎯 Hands-on Exercise:
Create login screen with animated button
Time: 20 minutes
```

**3. Explicit Animations (60 min)**

```dart
// Navigate to: /week5/explicit-animations

📍 What to Show:
- AnimationController setup
- TickerProviderStateMixin
- Tween interpolation
- AnimatedBuilder
- Multiple animations with intervals

💡 Teaching Tips:
- Explain when to use vs implicit
- Live code AnimationController setup
- Show dispose() importance
- Demonstrate play/pause/reverse controls

🎯 Guided Coding:
Build rotating logo animation together
Time: 30 minutes

⚠️ Common Pitfalls:
- Forgetting dispose()
- Missing TickerProviderStateMixin
- Not understanding vsync
```

**4. Practice Time (30 min)**

```
Students practice:
1. AnimatedContainer color changes
2. Fade in/out transitions
3. Rotation animation with controller

Instructor circulates and helps
```

#### Closing Session 2 (15 min)

```
1. Recap: Implicit vs Explicit
2. Show animation demo screen
3. Preview Session 3 (Hero & transitions)
4. Homework: Add animations to existing app
```

---

### Session 3: Advanced Topics & Task

#### Opening (10 min)

```
1. Review Session 2 homework
2. Show Hero animation examples (real apps)
3. Introduce weekly task
```

#### Main Content

**1. Hero Animations (45 min)**

```dart
// Navigate to: /week5/hero-transitions

📍 What to Show:
- Basic Hero with matching tags
- Image Hero transition
- List to detail pattern
- Hero with complex widgets

💡 Teaching Tips:
- Show real-world examples (photo gallery)
- Emphasize unique tag requirement
- Demonstrate tag mismatch errors
- Show Material wrapper for text

🎯 Interactive Demo:
Product list with Hero images
Time: 25 minutes
```

**2. Custom Page Transitions (45 min)**

```dart
// Navigate to: /week5/hero-transitions (PageRouteBuilder examples)

📍 What to Show:
- SlideTransition (4 directions)
- FadeTransition
- ScaleTransition
- Combined transitions (fade + slide)

💡 Teaching Tips:
- Start with PageRouteBuilder anatomy
- Show each transition separately
- Combine for custom effects
- Reference custom_page_route.dart utilities

🎯 Hands-on:
Implement custom slide transition
Time: 20 minutes
```

**3. Combined Navigation & Animation Demo (30 min)**

```dart
// Navigate to: /week5/navigation-demo
// Navigate to: /week5/animation-demo

📍 What to Show:
- All patterns working together
- Navigation with custom transitions
- Animated form fields
- Complete user flows

💡 Teaching Tips:
- Walk through code structure
- Explain integration points
- Show reusable widgets (AnimatedCard)
```

**4. Weekly Task Introduction (30 min)**

```dart
// Navigate to: /week5/weekly-task

📍 Task Requirements:
✅ Animated menu screen
✅ Hero transitions between screens
✅ Custom page transitions
✅ Form with animated validation
✅ 4-5 connected screens

💡 Teaching Tips:
- Show completed task demo
- Break down into steps
- Show starter template
- Explain rubric criteria

📋 Task Breakdown:
1. Menu screen (AnimatedCard grid)
2. Login with validation animations
3. Profile with Hero image
4. Settings with animated toggles
5. Navigation connecting all screens
```

**5. Guided Practice (30 min)**

```
Students start weekly task:
- Set up basic navigation
- Create menu screen
- Implement one transition

Instructor helps with setup
```

#### Closing Session 3 (15 min)

```
1. Recap all Week 5 concepts
2. Task submission requirements
3. Assessment criteria
4. Q&A
5. Resources for further learning
```

---

## 🎬 How to Present Each Component

### For Concept Files (01-09)

**Structure to Follow:**

1. **Introduction (5 min)**

   - What is this concept?
   - Why is it important?
   - Real-world examples

2. **Theory (10 min)**

   - Key terminology
   - How it works
   - Diagrams/visualizations

3. **Live Demo (15 min)**

   - Run the concept file
   - Walk through examples
   - Change values live
   - Show results

4. **Hands-on (15 min)**

   - Students try exercises
   - Instructor circulates
   - Help with errors

5. **Discussion (5 min)**
   - Common pitfalls
   - Best practices
   - Questions

### For Simple Learning File (week5_simple.dart)

**Progressive Learning Approach:**

```dart
// Session 1: Uncomment Lessons 1-6 (Navigation)
// Session 2: Uncomment Lessons 7-8 (Basic Animations)
// Session 3: Uncomment Lessons 9-12 (Advanced)
```

**Teaching Method:**

1. Show commented code structure
2. Explain what will be learned
3. Uncomment ONE lesson at a time
4. Hot reload and see changes
5. Explain code line by line
6. Students uncomment and experiment
7. Move to next lesson

**Tips:**

- Don't skip ahead - progressive is key
- Let students uncomment at their pace
- Encourage experimentation
- Celebrate "aha!" moments

---

## 💻 Live Demo Tips

### Setup Before Class

```bash
# 1. Ensure app runs
flutter run

# 2. Have main.dart open
# 3. Have week5_simple.dart open
# 4. Browser with Flutter docs ready
# 5. Emulator/device ready
```

### During Demos

**Do's:**

- ✅ Zoom in code editor (font size 18-20)
- ✅ Use hot reload frequently
- ✅ Explain BEFORE coding
- ✅ Show errors and fix them
- ✅ Use print statements for debugging
- ✅ Navigate through app showing features
- ✅ Use animations at normal speed first, then slow (timeDilation)

**Don'ts:**

- ❌ Type too fast
- ❌ Skip error messages
- ❌ Assume prior knowledge
- ❌ Use complex examples first
- ❌ Forget to save files
- ❌ Have too many tabs open

### Interactive Techniques

**Engagement Methods:**

1. **Call and Response**: "What happens if we push here?"
2. **Predict Before Run**: "What will happen when we hot reload?"
3. **Find the Bug**: Show broken code, students fix it
4. **Live Voting**: "A or B: Which navigation pattern?"
5. **Pair Programming**: Students navigate while instructor codes

---

## 🎓 Student Learning Path

### Self-Paced Learning Order

**Week 5 Day 1-2: Navigation**

```
1. Read week5/README.md (30 min)
2. week5_simple.dart - Lessons 1-4 (1 hour)
3. Navigation Basics concept (30 min)
4. Navigator Widget concept (45 min)
5. Practice: Create 3-screen app (1 hour)
```

**Week 5 Day 3-4: Advanced Navigation**

```
6. week5_simple.dart - Lessons 5-6 (1 hour)
7. Drawer concept (30 min)
8. Bottom Nav concept (30 min)
9. Named Routes concept (30 min)
10. Practice: Add drawer + bottom nav (1 hour)
```

**Week 5 Day 5-6: Animations**

```
11. week5_simple.dart - Lessons 7-8 (1 hour)
12. Animation Basics concept (45 min)
13. Implicit Animations concept (45 min)
14. Explicit Animations concept (1 hour)
15. Practice: Animate existing app (1.5 hours)
```

**Week 5 Day 7: Advanced Animations**

```
16. week5_simple.dart - Lessons 9-11 (1.5 hours)
17. Hero Transitions concept (45 min)
18. Practice: Product list with Hero (1 hour)
```

**Week 5 Day 8-10: Weekly Task**

```
19. Review weekly_task_screen.dart (30 min)
20. Complete weekly task (4-6 hours)
21. Test and refine (1 hour)
22. Submit with documentation (30 min)
```

### Learning Resources

**Official Documentation:**

- [Flutter Navigation](https://docs.flutter.dev/cookbook/navigation)
- [Flutter Animations](https://docs.flutter.dev/development/ui/animations)
- [Hero Animations](https://docs.flutter.dev/development/ui/animations/hero-animations)

**Practice Exercises:**

- See README.md Practice Exercises section
- Beginner → Intermediate → Advanced

---

## 📊 Assessment Criteria

### Weekly Task Rubric (100 points)

**Navigation Implementation (30 points)**

- [ ] Multiple screens with proper navigation (10 pts)
- [ ] Drawer or Bottom Navigation implemented (10 pts)
- [ ] Data passing between screens (5 pts)
- [ ] Proper back navigation handling (5 pts)

**Animation Implementation (30 points)**

- [ ] Hero animations on at least 2 screens (10 pts)
- [ ] Custom page transitions between screens (10 pts)
- [ ] Implicit animations (buttons, cards) (5 pts)
- [ ] Loading/success animations (5 pts)

**Code Quality (20 points)**

- [ ] Clean code structure (5 pts)
- [ ] Proper widget decomposition (5 pts)
- [ ] Comments and documentation (5 pts)
- [ ] No errors or warnings (5 pts)

**UX/Design (10 points)**

- [ ] Smooth transitions (5 pts)
- [ ] Consistent styling (5 pts)

**Creativity (10 points)**

- [ ] Original implementation (5 pts)
- [ ] Extra features/animations (5 pts)

### Grading Scale

- 90-100: Excellent (A)
- 80-89: Good (B)
- 70-79: Satisfactory (C)
- 60-69: Needs Improvement (D)
- <60: Incomplete (F)

### Submission Requirements

1. Complete Flutter project folder
2. Screenshots/video of app running (1-2 min)
3. Brief documentation (500 words):
   - Features implemented
   - Challenges faced
   - Learning outcomes
   - Code explanations

---

## ❓ Common Questions & Answers

### Navigation Questions

**Q: When should I use named routes vs direct routes?**
A: Use named routes when:

- App has 5+ screens
- Need deep linking
- Want centralized routing
- Multiple developers

Use direct routes when:

- Small app (2-4 screens)
- Prototyping
- Quick POC

**Q: Drawer vs Bottom Navigation - which to choose?**
A:

- **Drawer**: 5+ destinations, less frequent switching, hierarchical structure
- **Bottom Navigation**: 3-5 destinations, frequent switching, flat structure

**Q: How do I prevent back button on certain screens?**
A: Use `WillPopScope` widget or `Navigator.pushReplacement()`

### Animation Questions

**Q: Implicit vs Explicit - when to use each?**
A:

- **Implicit**: Simple property changes (color, size, opacity) - 80% of cases
- **Explicit**: Complex sequences, precise control, multiple coordinated animations - 20% of cases

**Q: Why do animations feel sluggish?**
A: Check:

1. Duration (should be 200-400ms)
2. Curve (use easeInOut for smooth feel)
3. Heavy widgets (use RepaintBoundary)
4. Debug mode (release is faster)

**Q: Hero animation not working?**
A: Verify:

1. Both screens have Hero with SAME tag
2. Hero wraps the widget completely
3. No duplicate tags on same screen
4. Using Material/CupertinoPageRoute

### Code Questions

**Q: "Bad state: cannot add new events after calling close" error?**
A: AnimationController not disposed. Add `dispose()` override:

```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

**Q: "TickerProviderStateMixin" error?**
A: Change:

```dart
class MyState extends State<MyWidget>
  with SingleTickerProviderStateMixin { // Add this
```

---

## 🔧 Troubleshooting

### Common Errors & Solutions

**1. Navigator Operation Requested with a Context...**

```dart
// Problem:
Navigator.push(context, ...); // Called before MaterialApp builds

// Solution:
// Use Builder or extract to separate widget
Builder(
  builder: (context) => ElevatedButton(
    onPressed: () => Navigator.push(context, ...),
  ),
)
```

**2. Hero Animation Mismatch**

```dart
// Problem:
Hero(tag: 'hero1', child: Image(...)) // Screen 1
Hero(tag: 'hero2', child: Image(...)) // Screen 2 (different tag!)

// Solution:
// Use SAME tag on both screens
Hero(tag: 'hero1', child: Image(...))
```

**3. Animation Jank (Stuttering)**

```dart
// Problem:
AnimatedBuilder rebuilding too much

// Solution:
AnimatedBuilder(
  animation: _animation,
  child: ExpensiveWidget(), // Built once
  builder: (context, child) => Transform.rotate(
    angle: _animation.value,
    child: child, // Reuse child
  ),
)
```

**4. State Lost on Tab Switch**

```dart
// Problem:
Using regular Column/Stack for tabs

// Solution:
// Use IndexedStack to preserve state
IndexedStack(
  index: _currentIndex,
  children: [Screen1(), Screen2(), Screen3()],
)
```

---

## 📝 Instructor Checklist

### Before Class

- [ ] Test all demos on target devices
- [ ] Verify all routes work in main.dart
- [ ] Prepare code snippets for copy-paste
- [ ] Have backup project (if demo breaks)
- [ ] Check internet connection (for pub get)
- [ ] Prepare whiteboard diagrams
- [ ] Print handouts (optional)

### During Class

- [ ] Engage with questions frequently
- [ ] Check student understanding (polls)
- [ ] Circulate during hands-on time
- [ ] Note common errors for review
- [ ] Keep track of time
- [ ] Take breaks every 45-60 min

### After Class

- [ ] Share code repository link
- [ ] Post slides/recordings
- [ ] Answer questions (email/forum)
- [ ] Review submissions promptly
- [ ] Gather feedback for improvement

---

## 🎯 Success Metrics

### Students Should Be Able To

**End of Session 1:**

- ✅ Navigate between screens using Navigator
- ✅ Pass data between screens
- ✅ Implement drawer navigation
- ✅ Create bottom navigation bar
- ✅ Use named routes

**End of Session 2:**

- ✅ Understand animation principles
- ✅ Implement implicit animations
- ✅ Use AnimationController
- ✅ Apply proper curves and timing
- ✅ Animate existing UI elements

**End of Session 3:**

- ✅ Implement Hero animations
- ✅ Create custom page transitions
- ✅ Combine navigation + animations
- ✅ Complete weekly task independently
- ✅ Debug common animation issues

---

## 📚 Additional Resources

### For Instructors

- Flutter Animations Codelab: <https://codelabs.developers.google.com/codelabs/flutter-animations>
- Material Motion Guidelines: <https://material.io/design/motion>
- Animation Best Practices: <https://flutter.dev/docs/development/ui/animations/tutorial>

### For Students

- FlutterFire documentation
- Animations package examples
- Community animations library: <https://pub.dev/packages/animations>
- Rive for complex animations: <https://rive.app>

### Video Resources

- Flutter Widget of the Week (animations)
- The Boring Flutter Show (navigation episodes)
- Flutter Community YouTube channel

---

## 🎊 Teaching Philosophy

**Remember:**

- 🧠 **Learn by Doing**: 70% hands-on, 30% lecture
- 🎯 **Progressive Complexity**: Simple → Complex
- 🤝 **Collaborative**: Encourage peer learning
- 💪 **Embrace Errors**: Errors are learning opportunities
- 🎨 **Creativity**: Let students experiment
- 📈 **Growth Mindset**: Celebrate progress, not perfection

**Week 5 Motto**: _"Motion makes emotion - great animations create great experiences!"_

---

## 📧 Support

For questions about these materials:

- Check README.md in week5/ folder
- Review concept files inline comments
- Consult Flutter documentation
- Ask in course forum/Discord

---

**Happy Teaching! 🚀**

_Last Updated: Week 5 Materials Complete_

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum SlideTransitionDirection { top, right, left, bottom }

class PageTranition {
  static Page<void> fade(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, animation2, child) =>
            FadeTransition(opacity: animation, child: child),
      );

  static Page<void> scale(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, animation2, child) =>
            ScaleTransition(scale: animation, child: child),
      );

  static Page<void> _slidePageTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
    SlideTransitionDirection direction,
  ) =>
      CustomTransitionPage<void>(
        transitionDuration: const Duration(microseconds: 800),
        key: state.pageKey,
        child: child,
        transitionsBuilder: (context, animation, animation2, child) {
          final begin = switch (direction) {
            SlideTransitionDirection.top => const Offset(0, 1),
            SlideTransitionDirection.right => const Offset(1, 0),
            SlideTransitionDirection.left => const Offset(-1, 0),
            _ => const Offset(1, 0),
          };
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
      );

  static Page<void> slideUp(
          BuildContext context, GoRouterState state, Widget child) =>
      _slidePageTransition(context, state, child, SlideTransitionDirection.top);

  static Page<void> slideRight(
          BuildContext context, GoRouterState state, Widget child) =>
      _slidePageTransition(
          context, state, child, SlideTransitionDirection.right);

  static Page<void> slideLeft(
          BuildContext context, GoRouterState state, Widget child) =>
      _slidePageTransition(
          context, state, child, SlideTransitionDirection.left);

  static Page<void> slideDown(
          BuildContext context, GoRouterState state, Widget child) =>
      _slidePageTransition(
          context, state, child, SlideTransitionDirection.bottom);
}

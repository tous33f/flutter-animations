import 'package:flutter/material.dart';

import '../models/place.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({
    super.key,
    required this.place,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onTap,
  });

  final Place place;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onTap;

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isFavorite
              ? const Color(0xFFF0EEFF)
              : (_pressed ? const Color(0xFFF7F8FC) : Colors.white),
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withAlpha(_pressed ? 8 : 22),
              blurRadius: _pressed ? 4 : 14,
              offset: Offset(0, _pressed ? 2 : 8),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'place-image-${widget.place.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  widget.place.imageUrl,
                  width: 122,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (
                        BuildContext context,
                        Object error,
                        StackTrace? stackTrace,
                      ) {
                        return Container(
                          width: 122,
                          height: 90,
                          color: const Color(0xFFE1E4F2),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.landscape,
                            color: Colors.indigo,
                          ),
                        );
                      },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.place.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Color(0xFF644CF1),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.place.location,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.textTheme.bodySmall?.color?.withAlpha(
                              170,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeInOut,
              opacity: widget.isFavorite ? 1 : 0.35,
              child: IconButton(
                onPressed: widget.onFavoriteTap,
                icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.isFavorite
                      ? const Color(0xFFFF5A6D)
                      : Colors.indigo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

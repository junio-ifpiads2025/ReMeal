import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/restaurant_model.dart';
import '../models/user_review.dart'; // Import necessário
import '../controller/user_review_controller.dart'; // Import necessário

class ReviewPage extends ConsumerStatefulWidget {
  final RestaurantModel restaurant;

  const ReviewPage({super.key, required this.restaurant});

  @override
  ConsumerState<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends ConsumerState<ReviewPage> {
  double _currentRating = 0.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() async {
    if (_currentRating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, dê uma nota em estrelas.')),
      );
      return;
    }

    // passar os dados no formato do modelo UserReview
    final newReview = UserReview(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      restaurantName: widget.restaurant.name,
      imageUrl: widget.restaurant.imageUrl, 
      rating: _currentRating,
      comment: _commentController.text.trim().isNotEmpty 
          ? _commentController.text.trim()
          : "Sem comentário.",
      date: DateTime.now().toIso8601String().substring(0, 10),
    );

    await ref.read(userReviewControllerProvider.notifier).addReview(newReview);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Avaliação para ${widget.restaurant.name} enviada'),
        duration: const Duration(seconds: 2),
      ),
    );

    // Retorna página anterior
    Navigator.of(context).pop(); 
  }

  // widget estrelas clicaveis
  Widget _buildRatingBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        bool isFilled = index < _currentRating.floor();

        Color starColor = isFilled ? Colors.orange : Colors.grey;

        return IconButton(
          icon: Icon(
            isFilled ? Icons.star : Icons.star_border,
            size: 36,
            color: starColor,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1.0;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Avaliar Restaurante',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // nome e foto
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      widget.restaurant.imageUrl,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.restaurant.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            
            // estrelas
            const Text(
              'A sua pontuação:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            _buildRatingBar(),
            Text(
              'Nota: ${_currentRating.toStringAsFixed(1)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),

            const SizedBox(height: 32),

            // comentário
            const Text(
              'O seu comentário:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Escreva a sua opinião sobre o restaurante...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            
            const SizedBox(height: 50), 
          ],
        ),
      ),

      // botão Enviar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _submitReview, // Chama o novo método de submissão
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Enviar Avaliação',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
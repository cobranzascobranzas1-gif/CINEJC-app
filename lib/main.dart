import 'package:flutter/material.dart';

void main() {
  runApp(const CineApp());
}

class CineApp extends StatelessWidget {
  const CineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CINEJC Streaming',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0E12),
        primaryColor: Colors.redAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0E12),
          elevation: 0,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.redAccent,
          secondary: Colors.blueAccent,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    MoviesScreen(),
    LiveTvScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF14161D),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            activeIcon: Icon(Icons.movie_creation),
            label: 'Películas & Series',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_outlined),
            activeIcon: Icon(Icons.tv),
            label: 'TV en Vivo',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PANTALLA PRINCIPAL DE PELÍCULAS Y PLATAFORMAS
// ---------------------------------------------------------------------------
class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  int _selectedTab = 0; // 0: TRENDING, 1: IN THEATER, 2: POPULAR
  String _selectedPlatform = 'TODAS';

  final List<String> _platforms = [
    'NETFLIX',
    'Disney+',
    'prime video',
    'K-DRAMA',
    'tv+',
    'Paramount+',
    'HBO max',
    'hulu',
    'AMC',
    'peacock',
    'MARVEL',
    'STARZ'
  ];

  final List<Map<String, String>> _movies = [
    {
      'title': 'Digger',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=1'
    },
    {
      'title': 'Resident Evil',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=2'
    },
    {
      'title': 'Runner',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=3'
    },
    {
      'title': 'UNABOMBER',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=4'
    },
    {
      'title': 'Obsession',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=5'
    },
    {
      'title': 'Verity',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=6'
    },
    {
      'title': 'Coyote vs. Acme',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=7'
    },
    {
      'title': 'The Uprising',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=8'
    },
    {
      'title': 'Spider-Man',
      'year': '2026',
      'image': 'https://picsum.photos/300/450?random=9'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(
          _selectedPlatform == 'TODAS'
              ? 'MOVIES: TRENDING...'
              : 'MOVIES: $_selectedPlatform',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Buscando dispositivos Chromecast...')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Sub-pestanas: TRENDING, IN THEATER, POPULAR
          Row(
            children: [
              _buildTabButton('TRENDING', 0),
              _buildTabButton('IN THEATER', 1),
              _buildTabButton('POPULAR', 2),
            ],
          ),
          const SizedBox(height: 8),

          // Carrusel Horizontal de Plataformas
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: _platforms.length,
              itemBuilder: (context, index) {
                final platform = _platforms[index];
                final isSelected = _selectedPlatform == platform;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(
                      platform,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.black : Colors.white,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Colors.white,
                    backgroundColor: const Color(0xFF1E222D),
                    onSelected: (selected) {
                      setState(() {
                        _selectedPlatform = selected ? platform : 'TODAS';
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          // Grilla de Peliculas
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.58,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
              ),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              movie['image']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: Colors.grey[800],
                                child: const Icon(Icons.movie, size: 40),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              left: 4,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.remove_circle_outline,
                                  size: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      movie['title']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      movie['year']!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.blueAccent : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PANTALLA DE TV EN VIVO (POR PAÍSES LATINOAMERICANOS)
// ---------------------------------------------------------------------------
class LiveTvScreen extends StatelessWidget {
  const LiveTvScreen({super.key});

  final List<Map<String, String>> _countries = const [
    {'name': 'Bolivia', 'flag': '🇧🇴', 'channels': '15 Canales'},
    {'name': 'México', 'flag': '🇲🇽', 'channels': '42 Canales'},
    {'name': 'Argentina', 'flag': '🇦🇷', 'channels': '35 Canales'},
    {'name': 'Colombia', 'flag': '🇨🇴', 'channels': '28 Canales'},
    {'name': 'Chile', 'flag': '🇨🇱', 'channels': '22 Canales'},
    {'name': 'Perú', 'flag': '🇵🇪', 'channels': '20 Canales'},
    {'name': 'Deportes En Vivo', 'flag': '⚽', 'channels': '18 Canales'},
    {'name': 'Noticias 24/7', 'flag': '📰', 'channels': '12 Canales'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV EN VIVO - LATINOAMÉRICA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _countries.length,
        itemBuilder: (context, index) {
          final item = _countries[index];
          return Card(
            color: const Color(0xFF1A1D24),
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Text(
                item['flag']!,
                style: const TextStyle(fontSize: 28),
              ),
              title: Text(
                item['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                item['channels']!,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Cargando canales de ${item['name']}...'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

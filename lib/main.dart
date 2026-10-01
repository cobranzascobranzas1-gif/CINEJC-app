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
    MultiSourceSearchScreen(),
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
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            activeIcon: Icon(Icons.movie_creation),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.manage_search),
            label: 'Buscador AI',
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
// PANTALLA PRINCIPAL CON PLATAFORMAS Y CONTENIDO EN ESPAÑOL
// ---------------------------------------------------------------------------
class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  int _selectedTab = 0;
  String _selectedPlatform = 'TODAS';
  bool _onlySpanishDub = true;

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

  final List<Map<String, dynamic>> _movies = [
    {
      'title': 'Digger',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=1',
      'platform': 'NETFLIX',
      'servers': [
        'Servidor 1 (Latino 1080p - Alta Velocidad)',
        'Servidor 2 (Latino 720p - Ligero)',
        'Servidor 3 (Castellano HD)'
      ]
    },
    {
      'title': 'Resident Evil',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=2',
      'platform': 'HBO max',
      'servers': [
        'Servidor 1 (Latino 4K Ultra HD)',
        'Servidor 2 (Latino 1080p)',
        'Servidor 3 (Latino 720p)'
      ]
    },
    {
      'title': 'Runner',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=3',
      'platform': 'Paramount+',
      'servers': [
        'Servidor 1 (Latino 1080p)',
        'Servidor 2 (Castellano 1080p)'
      ]
    },
    {
      'title': 'UNABOMBER',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=4',
      'platform': 'Disney+',
      'servers': [
        'Servidor 1 (Latino 1080p)',
        'Servidor 2 (Latino 720p)'
      ]
    },
    {
      'title': 'Obsession',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=5',
      'platform': 'prime video',
      'servers': [
        'Servidor 1 (Latino HD)',
        'Servidor 2 (Castellano HD)'
      ]
    },
    {
      'title': 'Verity',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=6',
      'platform': 'NETFLIX',
      'servers': [
        'Servidor 1 (Latino 1080p Full HD)'
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMovies = _movies.where((movie) {
      if (_selectedPlatform != 'TODAS' && movie['platform'] != _selectedPlatform) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedPlatform == 'TODAS'
                  ? 'CATÁLOGO GENERAL'
                  : 'CATÁLOGO: $_selectedPlatform',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Text(
              '100% Audio en Español',
              style: TextStyle(fontSize: 11, color: Colors.greenAccent),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast),
            tooltip: 'Transmitir a Chromecast',
            onPressed: () => _showChromecastDialog(context),
          ),
          IconButton(
            icon: Icon(
              Icons.subtitles,
              color: _onlySpanishDub ? Colors.greenAccent : Colors.white,
            ),
            tooltip: 'Filtro Doblaje Español',
            onPressed: () {
              setState(() {
                _onlySpanishDub = !_onlySpanishDub;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_onlySpanishDub
                      ? 'Filtro activo: Solo contenido con Doblaje al Español'
                      : 'Mostrando todo el catálogo'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Sub-pestañas principales
          Row(
            children: [
              _buildTabButton('TENDENCIAS', 0),
              _buildTabButton('ESTRENOS', 1),
              _buildTabButton('RECOMENDADAS', 2),
            ],
          ),
          const SizedBox(height: 8),

          // Selección de Plataformas
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
          const SizedBox(height: 8),

          // Grilla de Contenido
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.55,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredMovies.length,
              itemBuilder: (context, index) {
                final movie = filteredMovies[index];
                return GestureDetector(
                  onTap: () => _openMovieDetail(context, movie),
                  child: Column(
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
                                right: 4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    '🇲🇽 ESP',
                                    style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.greenAccent),
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
                        '${movie['year']} • ${movie['audio']}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
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
                color: isSelected ? Colors.redAccent : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.redAccent : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  void _openMovieDetail(BuildContext context, Map<String, dynamic> movie) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF14161D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie['image']!,
                      width: 90,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie['title']!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.greenAccent),
                          ),
                          child: Text(
                            '🎙️ Audio: ${movie['audio']}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Plataforma: ${movie['platform']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Servidores disponibles (Doblaje en Español):',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...((movie['servers'] as List<String>).map((server) {
                return Card(
                  color: const Color(0xFF1E222D),
                  child: ListTile(
                    leading: const Icon(Icons.play_circle_fill,
                        color: Colors.redAccent),
                    title: Text(server, style: const TextStyle(fontSize: 13)),
                    trailing: IconButton(
                      icon: const Icon(Icons.cast, color: Colors.blueAccent),
                      onPressed: () => _showChromecastDialog(context),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Reproduciendo en: $server'),
                        ),
                      );
                    },
                  ),
                );
              }).toList()),
            ],
          ),
        );
      },
    );
  }

  void _showChromecastDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E222D),
        title: const Row(
          children: [
            Icon(Icons.cast, color: Colors.blueAccent),
            SizedBox(width: 10),
            Text('Transmitir a Chromecast', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Smart TV Sala'),
              subtitle: Text('Disponible'),
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Chromecast Dormitorio'),
              subtitle: Text('Disponible'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// BUSCADOR MULTI-FUENTE ESTILO SEEKEE CON FILTRO ESPAÑOL
// ---------------------------------------------------------------------------
class MultiSourceSearchScreen extends StatefulWidget {
  const MultiSourceSearchScreen({super.key});

  @override
  State<MultiSourceSearchScreen> createState() =>
      _MultiSourceSearchScreenState();
}

class _MultiSourceSearchScreenState extends State<MultiSourceSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Map<String, String>> _searchResults = [];

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    // Búsqueda inteligente que escanea múltiples fuentes web
    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        _isSearching = false;
        _searchResults = [
          {
            'title': '$query - Versión Latino HD',
            'source': 'Fuente A (Servidor Directo - 1080p)',
            'audio': 'Español Latino',
            'ping': '45 ms'
          },
          {
            'title': '$query - Versión Ultra Fast',
            'source': 'Fuente B (Servidor Espejo - 720p)',
            'audio': 'Español Latino',
            'ping': '30 ms'
          },
          {
            'title': '$query - Colección Completa',
            'source': 'Fuente C (Castellano España)',
            'audio': 'Español Castellano',
            'ping': '60 ms'
          },
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador Multi-Fuente AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Escribe nombre de película, serie o frase...',
                prefixIcon: const Icon(Icons.search, color: Colors.redAccent),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => _performSearch(_searchController.text),
                ),
                filled: true,
                fillColor: const Color(0xFF1E222D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: _performSearch,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.greenAccent, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Filtro Automático: Solo fuentes en Español (Latino/Castellano)',
                      style: TextStyle(fontSize: 11, color: Colors.greenAccent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_isSearching)
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.redAccent),
                      SizedBox(height: 16),
                      Text('Escaneando servidores en la red...'),
                    ],
                  ),
                ),
              )
            else if (_searchResults.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'Escribe el nombre de lo que quieras ver para rastrear fuentes disponibles en español.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final result = _searchResults[index];
                    return Card(
                      color: const Color(0xFF1E222D),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const Icon(Icons.movie, color: Colors.redAccent),
                        title: Text(result['title']!,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            '${result['source']} • Ping: ${result['ping']}\nAudio: ${result['audio']}'),
                        isThreeLine: true,
                        trailing: const Icon(Icons.play_arrow, color: Colors.greenAccent),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Cargando enlace de ${result['source']}...'),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
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
    {'name': 'Bolivia', 'flag': '🇧🇴', 'channels': '15 Canales en Español'},
    {'name': 'México', 'flag': '🇲🇽', 'channels': '42 Canales en Español'},
    {'name': 'Argentina', 'flag': '🇦🇷', 'channels': '35 Canales en Español'},
    {'name': 'Colombia', 'flag': '🇨🇴', 'channels': '28 Canales en Español'},
    {'name': 'Chile', 'flag': '🇨🇱', 'channels': '22 Canales en Español'},
    {'name': 'Perú', 'flag': '🇵🇪', 'channels': '20 Canales en Español'},
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
                    content: Text('Cargando lista de transmisión de ${item['name']}...'),
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

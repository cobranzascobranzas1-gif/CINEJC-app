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
// 1. PANTALLA PRINCIPAL: TENDENCIAS Y PLATAFORMAS (NETFLIX, MAX, DISNEY, ETC.)
// ---------------------------------------------------------------------------
class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _platforms = [
    {'name': 'NETFLIX', 'color': Colors.red},
    {'name': 'Disney+', 'color': Colors.blue},
    {'name': 'prime video', 'color': Colors.cyan},
    {'name': 'HBO max', 'color': Colors.purple},
    {'name': 'Paramount+', 'color': Colors.blueAccent},
    {'name': 'K-DRAMA', 'color': Colors.pink},
    {'name': 'tv+', 'color': Colors.grey},
    {'name': 'hulu', 'color': Colors.green},
    {'name': 'STARZ', 'color': Colors.orange},
  ];

  final List<Map<String, dynamic>> _movies = [
    {
      'title': 'Digger',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=1',
      'platform': 'NETFLIX',
    },
    {
      'title': 'Resident Evil',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=2',
      'platform': 'HBO max',
    },
    {
      'title': 'Runner',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=3',
      'platform': 'Paramount+',
    },
    {
      'title': 'UNABOMBER',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=4',
      'platform': 'Disney+',
    },
    {
      'title': 'Obsession',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=5',
      'platform': 'prime video',
    },
    {
      'title': 'Verity',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/300/450?random=6',
      'platform': 'NETFLIX',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MOVIES: TRENDING',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '100% Doblaje en Español Latino',
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
        ],
      ),
      body: Column(
        children: [
          // Sub-pestañas superiores
          Row(
            children: [
              _buildTabButton('TRENDING', 0),
              _buildTabButton('IN THEATER', 1),
              _buildTabButton('POPULAR', 2),
            ],
          ),
          const SizedBox(height: 8),

          // Carrusel horizontal de plataformas
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: _platforms.length,
              itemBuilder: (context, index) {
                final platform = _platforms[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ActionChip(
                    backgroundColor: const Color(0xFF1E222D),
                    side: BorderSide(color: platform['color'] as Color, width: 1.5),
                    label: Text(
                      platform['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlatformDetailScreen(
                            platformName: platform['name'] as String,
                            platformColor: platform['color'] as Color,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Grilla de Películas/Series
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.55,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
              ),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(
                          title: movie['title']!,
                          subtitle: '${movie['platform']} • ${movie['audio']}',
                          imageUrl: movie['image']!,
                          isLiveTv: false,
                        ),
                      ),
                    );
                  },
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
                                errorBuilder: (context, error, stackTrace) => Container(
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
                                    '🇲🇽 LATINO',
                                    style: TextStyle(
                                        fontSize: 8,
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
                        '${movie['year']} • ${movie['platform']}',
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

  void _showChromecastDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E222D),
        title: const Row(
          children: [
            Icon(Icons.cast, color: Colors.blueAccent),
            SizedBox(width: 10),
            Text('Dispositivos Chromecast', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Smart TV Sala'),
              subtitle: Text('Listo para transmitir'),
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Chromecast Dormitorio'),
              subtitle: Text('Listo para transmitir'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. DETALLE INTERNO DE CADA PLATAFORMA (NETFLIX, DISNEY+, HBO MAX, ETC.)
// ---------------------------------------------------------------------------
class PlatformDetailScreen extends StatelessWidget {
  final String platformName;
  final Color platformColor;

  const PlatformDetailScreen({
    super.key,
    required this.platformName,
    required this.platformColor,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> platformCatalog = [
      {'title': 'Serie Exclusiva 1', 'type': 'Serie • Temp 1', 'img': 'https://picsum.photos/300/450?random=21'},
      {'title': 'Estreno $platformName', 'type': 'Película • 2026', 'img': 'https://picsum.photos/300/450?random=22'},
      {'title': 'Top Recomendado', 'type': 'Película • Latino', 'img': 'https://picsum.photos/300/450?random=23'},
      {'title': 'Tendencia de la Semana', 'type': 'Serie • Temp 3', 'img': 'https://picsum.photos/300/450?random=24'},
      {'title': 'Especial $platformName', 'type': 'Película • 4K', 'img': 'https://picsum.photos/300/450?random=25'},
      {'title': 'Producción Original', 'type': 'Serie • Latino', 'img': 'https://picsum.photos/300/450?random=26'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('CATÁLOGO: $platformName', style: TextStyle(color: platformColor, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [platformColor.withOpacity(0.8), const Color(0xFF14161D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    platformName,
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Explora las mejores series y películas de esta plataforma con doblaje en español latino.',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Destacados de esta plataforma',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.55,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
              ),
              itemCount: platformCatalog.length,
              itemBuilder: (context, index) {
                final item = platformCatalog[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(
                          title: item['title']!,
                          subtitle: '$platformName • ${item['type']}',
                          imageUrl: item['img']!,
                          isLiveTv: false,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item['img']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['title']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item['type']!,
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. BUSCADOR AI MULTI-FUENTE (SEEKEE REQUISITO 1)
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

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        _isSearching = false;
        _searchResults = [
          {
            'title': '$query - Versión Latino HD 1080p',
            'source': 'Servidor Principal (42 ms)',
            'audio': 'Español Latino',
            'quality': '1080p Full HD'
          },
          {
            'title': '$query - Versión Ultra Fast',
            'source': 'Servidor Espejo (28 ms)',
            'audio': 'Español Latino',
            'quality': '720p HD'
          },
          {
            'title': '$query - Opción Castellano',
            'source': 'Servidor Europeo (65 ms)',
            'audio': 'Español Castellano',
            'quality': '1080p Full HD'
          },
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador AI Multi-Fuente (SEEKEE)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Busca película, serie o describe la escena...',
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
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.greenAccent, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Filtro Activo: Escaneando únicamente fuentes con Audio Español',
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
                      Text('Rastreando servidores y enlaces web...'),
                    ],
                  ),
                ),
              )
            else if (_searchResults.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'Ingresa el nombre o concepto de lo que deseas ver.',
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
                    final res = _searchResults[index];
                    return Card(
                      color: const Color(0xFF1E222D),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const Icon(Icons.movie, color: Colors.redAccent),
                        title: Text(res['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        subtitle: Text('${res['source']} • ${res['quality']}\nAudio: ${res['audio']}'),
                        isThreeLine: true,
                        trailing: const Icon(Icons.play_circle_fill, color: Colors.greenAccent, size: 30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                title: res['title']!,
                                subtitle: '${res['audio']} • ${res['quality']}',
                                imageUrl: 'https://picsum.photos/600/350?random=${index + 80}',
                                isLiveTv: false,
                              ),
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
// 4. TV EN VIVO (POR PAÍSES LATINOAMERICANOS)
// ---------------------------------------------------------------------------
class LiveTvScreen extends StatelessWidget {
  const LiveTvScreen({super.key});

  final List<Map<String, dynamic>> _countries = const [
    {
      'name': 'Bolivia',
      'flag': '🇧🇴',
      'channels': [
        {'name': 'Unitel HD', 'show': 'Telepaís En Vivo', 'logo': '📺'},
        {'name': 'Red Uno', 'show': 'Notivisión En Vivo', 'logo': '📺'},
        {'name': 'Bolivisión', 'show': 'Al Día Noticiero', 'logo': '📺'},
        {'name': 'ATB Red Nacional', 'show': 'Encuentro Digital', 'logo': '📺'},
      ]
    },
    {
      'name': 'México',
      'flag': '🇲🇽',
      'channels': [
        {'name': 'Las Estrellas', 'show': 'Telenovela Estelar Live', 'logo': '📺'},
        {'name': 'Azteca Uno', 'show': 'Hechos Noche En Vivo', 'logo': '📺'},
        {'name': 'Canal 5', 'show': 'Cine Estelar Latino', 'logo': '📺'},
        {'name': 'Azteca 7', 'show': 'Deportes En Vivo', 'logo': '📺'},
      ]
    },
    {
      'name': 'Argentina',
      'flag': '🇦🇷',
      'channels': [
        {'name': 'Telefe HD', 'show': 'Telefe Noticias En Vivo', 'logo': '📺'},
        {'name': 'El Trece', 'show': 'Telenoche En Vivo', 'logo': '📺'},
        {'name': 'TyC Sports', 'show': 'Programa Deportivo', 'logo': '⚽'},
        {'name': 'TN Todo Noticias', 'show': 'Noticias 24hs', 'logo': '📰'},
      ]
    },
    {
      'name': 'Colombia',
      'flag': '🇨🇴',
      'channels': [
        {'name': 'Caracol TV', 'show': 'Noticias Caracol', 'logo': '📺'},
        {'name': 'RCN Televisión', 'show': 'Noticias RCN Live', 'logo': '📺'},
        {'name': 'Win Sports', 'show': 'Fútbol Profesional Live', 'logo': '⚽'},
      ]
    },
    {
      'name': 'Chile',
      'flag': '🇨🇱',
      'channels': [
        {'name': 'TVN Chile', 'show': '24 Horas Central', 'logo': '📺'},
        {'name': 'Mega HD', 'show': 'Meganoticias Prime', 'logo': '📺'},
        {'name': 'Chilevisión', 'show': 'CHV Noticias', 'logo': '📺'},
      ]
    },
    {
      'name': 'Perú',
      'flag': '🇵🇪',
      'channels': [
        {'name': 'América TV', 'show': 'América Noticias', 'logo': '📺'},
        {'name': 'ATV Perú', 'show': 'ATV Noticias En Vivo', 'logo': '📺'},
        {'name': 'Latina Televisión', 'show': 'Latina Noticias', 'logo': '📺'},
      ]
    },
    {
      'name': 'Deportes En Vivo',
      'flag': '⚽',
      'channels': [
        {'name': 'ESPN 1 Latino', 'show': 'SportsCenter En Vivo', 'logo': '⚽'},
        {'name': 'ESPN 2 Latino', 'show': 'Fútbol En Directo', 'logo': '⚽'},
        {'name': 'Fox Sports', 'show': 'Fórmula 1 & Champions', 'logo': '🏎️'},
      ]
    },
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
          final country = _countries[index];
          final channelsList = country['channels'] as List<Map<String, String>>;

          return Card(
            color: const Color(0xFF1A1D24),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Text(country['flag'] as String, style: const TextStyle(fontSize: 28)),
              title: Text(
                country['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text('${channelsList.length} Canales en vivo'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountryChannelsScreen(
                      countryName: country['name'] as String,
                      flag: country['flag'] as String,
                      channels: channelsList,
                    ),
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

// ---------------------------------------------------------------------------
// 5. CANALES DE TV DEL PAÍS SELECCIONADO
// ---------------------------------------------------------------------------
class CountryChannelsScreen extends StatelessWidget {
  final String countryName;
  final String flag;
  final List<Map<String, String>> channels;

  const CountryChannelsScreen({
    super.key,
    required this.countryName,
    required this.flag,
    required this.channels,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$flag Canales de $countryName'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: channels.length,
        itemBuilder: (context, index) {
          final channel = channels[index];
          return Card(
            color: const Color(0xFF1E222D),
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Text(channel['logo']!, style: const TextStyle(fontSize: 20)),
              ),
              title: Text(channel['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Row(
                children: [
                  const Icon(Icons.fiber_manual_record, color: Colors.red, size: 10),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      channel['show']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              trailing: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.play_arrow, size: 18, color: Colors.white),
                label: const Text('VER', style: TextStyle(color: Colors.white, fontSize: 12)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(
                        title: channel['name']!,
                        subtitle: 'Señal en Vivo • $countryName',
                        imageUrl: 'https://picsum.photos/600/350?random=${index + 50}',
                        isLiveTv: true,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. REPRODUCTOR DE VIDEO UNIFICADO CON SERVIDORES Y CHROMECAST
// ---------------------------------------------------------------------------
class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isLiveTv;

  const VideoPlayerScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.isLiveTv,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = true;
  double _currentSliderValue = 25.0;
  String _selectedServer = 'Servidor 1 (Latino HD)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.title, style: const TextStyle(fontSize: 16)),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.blueAccent),
            tooltip: 'Transmitir a Chromecast',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Conectando transmisión con Chromecast TV...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Pantalla del Reproductor
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  widget.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(color: Colors.black.withOpacity(0.4)),

                // Play / Pause Central
                IconButton(
                  iconSize: 64,
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),

                // Badge de EN VIVO
                if (widget.isLiveTv)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.fiber_manual_record, color: Colors.white, size: 10),
                          SizedBox(width: 4),
                          Text(
                            'EN VIVO',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Controles Inferiores
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.black54,
                    child: Row(
                      children: [
                        Text(
                          widget.isLiveTv ? 'REC • 1080p' : '00:25:40',
                          style: const TextStyle(fontSize: 11, color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            value: _currentSliderValue,
                            max: 100,
                            activeColor: Colors.redAccent,
                            inactiveColor: Colors.grey,
                            onChanged: widget.isLiveTv
                                ? null
                                : (val) {
                                    setState(() => _currentSliderValue = val);
                                  },
                          ),
                        ),
                        Text(
                          widget.isLiveTv ? 'EN DIRECTO' : '01:45:00',
                          style: const TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Selección de Servidores y Opciones
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF0D0E12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Cambiar Servidor / Calidad (Español):',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    value: _selectedServer,
                    dropdownColor: const Color(0xFF1E222D),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1E222D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Servidor 1 (Latino HD)',
                        child: Text('Servidor 1 (Latino 1080p - Recomendado)'),
                      ),
                      DropdownMenuItem(
                        value: 'Servidor 2 (Latino 720p)',
                        child: Text('Servidor 2 (Latino 720p - Ligero/Rápido)'),
                      ),
                      DropdownMenuItem(
                        value: 'Servidor 3 (Castellano)',
                        child: Text('Servidor 3 (Español Castellano HD)'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedServer = val);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Cambiando transmisión a: $val')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

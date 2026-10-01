import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
// 1. PANTALLA PRINCIPAL: TENDENCIAS Y PLATAFORMAS
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
  ];

  final List<Map<String, dynamic>> _movies = [
    {
      'title': 'Digger',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/id/1015/300/450',
      'platform': 'NETFLIX',
    },
    {
      'title': 'Resident Evil',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/id/1025/300/450',
      'platform': 'HBO max',
    },
    {
      'title': 'Runner',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/id/1035/300/450',
      'platform': 'Paramount+',
    },
    {
      'title': 'UNABOMBER',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/id/1045/300/450',
      'platform': 'Disney+',
    },
    {
      'title': 'Obsession',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/id/1055/300/450',
      'platform': 'prime video',
    },
    {
      'title': 'Verity',
      'year': '2026',
      'audio': 'Español Latino',
      'image': 'https://picsum.photos/id/1065/300/450',
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
      ),
      body: Column(
        children: [
          Row(
            children: [
              _buildTabButton('TRENDING', 0),
              _buildTabButton('IN THEATER', 1),
              _buildTabButton('POPULAR', 2),
            ],
          ),
          const SizedBox(height: 8),
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
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    '🇲🇽 LATINO',
                                    style: TextStyle(
                                        fontSize: 8, fontWeight: FontWeight.bold, color: Colors.greenAccent),
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
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${movie['year']} • ${movie['platform']}',
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
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
}

// ---------------------------------------------------------------------------
// 2. DETALLE INTERNO DE CADA PLATAFORMA
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
      {'title': 'Serie Exclusiva 1', 'type': 'Serie • Temp 1', 'img': 'https://picsum.photos/id/111/300/450'},
      {'title': 'Estreno $platformName', 'type': 'Película • 2026', 'img': 'https://picsum.photos/id/112/300/450'},
      {'title': 'Top Recomendado', 'type': 'Película • Latino', 'img': 'https://picsum.photos/id/113/300/450'},
      {'title': 'Tendencia de la Semana', 'type': 'Serie • Temp 3', 'img': 'https://picsum.photos/id/114/300/450'},
      {'title': 'Especial $platformName', 'type': 'Película • 4K', 'img': 'https://picsum.photos/id/115/300/450'},
      {'title': 'Producción Original', 'type': 'Serie • Latino', 'img': 'https://picsum.photos/id/116/300/450'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('CATÁLOGO: $platformName', style: TextStyle(color: platformColor, fontWeight: FontWeight.bold)),
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
                    'Explora las mejores series y películas con doblaje latino.',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text('Destacados de esta plataforma', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                          child: Image.network(item['img']!, fit: BoxFit.cover, width: double.infinity),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(item['title']!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(item['type']!, style: const TextStyle(fontSize: 10, color: Colors.grey)),
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
// 3. BUSCADOR AI MULTI-FUENTE (SEEKEE)
// ---------------------------------------------------------------------------
class MultiSourceSearchScreen extends StatefulWidget {
  const MultiSourceSearchScreen({super.key});

  @override
  State<MultiSourceSearchScreen> createState() => _MultiSourceSearchScreenState();
}

class _MultiSourceSearchScreenState extends State<MultiSourceSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Map<String, String>> _searchResults = [];

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    setState(() => _isSearching = true);

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        _isSearching = false;
        _searchResults = [
          {'title': '$query - Versión Latino HD', 'source': 'Servidor Principal', 'audio': 'Español Latino', 'quality': '1080p'},
          {'title': '$query - Versión Rápida', 'source': 'Servidor Espejo', 'audio': 'Español Latino', 'quality': '720p'},
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscador AI Multi-Fuente')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Busca película o serie...',
                prefixIcon: const Icon(Icons.search, color: Colors.redAccent),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => _performSearch(_searchController.text),
                ),
                filled: true,
                fillColor: const Color(0xFF1E222D),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
              onSubmitted: _performSearch,
            ),
            const SizedBox(height: 16),
            if (_isSearching)
              const Expanded(child: Center(child: CircularProgressIndicator(color: Colors.redAccent)))
            else if (_searchResults.isEmpty)
              const Expanded(child: Center(child: Text('Ingresa lo que deseas ver.', style: TextStyle(color: Colors.grey))))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final res = _searchResults[index];
                    return Card(
                      color: const Color(0xFF1E222D),
                      child: ListTile(
                        leading: const Icon(Icons.movie, color: Colors.redAccent),
                        title: Text(res['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
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
// 4. TV EN VIVO (LATINOAMÉRICA)
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
      ]
    },
    {
      'name': 'México',
      'flag': '🇲🇽',
      'channels': [
        {'name': 'Las Estrellas', 'show': 'Telenovela Estelar Live', 'logo': '📺'},
        {'name': 'Azteca Uno', 'show': 'Hechos Noche En Vivo', 'logo': '📺'},
      ]
    },
    {
      'name': 'Deportes',
      'flag': '⚽',
      'channels': [
        {'name': 'ESPN 1 Latino', 'show': 'SportsCenter En Vivo', 'logo': '⚽'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TV EN VIVO - LATINOAMÉRICA')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _countries.length,
        itemBuilder: (context, index) {
          final country = _countries[index];
          final channelsList = country['channels'] as List<Map<String, String>>;

          return Card(
            color: const Color(0xFF1A1D24),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Text(country['flag'] as String, style: const TextStyle(fontSize: 28)),
              title: Text(country['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
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
      appBar: AppBar(title: Text('$flag Canales de $countryName')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: channels.length,
        itemBuilder: (context, index) {
          final channel = channels[index];
          return Card(
            color: const Color(0xFF1E222D),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.2), shape: BoxShape.circle),
                child: Text(channel['logo']!, style: const TextStyle(fontSize: 20)),
              ),
              title: Text(channel['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(channel['show']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              trailing: const Icon(Icons.play_arrow, color: Colors.redAccent),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      title: channel['name']!,
                      subtitle: 'Señal en Vivo • $countryName',
                      isLiveTv: true,
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
// 5. REPRODUCTOR DE VIDEO REAL (CHEWIE + VIDEO_PLAYER)
// ---------------------------------------------------------------------------
class VideoPlayerScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isLiveTv;

  const VideoPlayerScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isLiveTv,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  String _selectedServer = 'Servidor 1 (Latino HD)';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    // Videos de prueba públicos para asegurar que reproduzca de verdad
    final videoUrl = widget.isLiveTv 
        ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4' 
        : 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      isLive: widget.isLiveTv,
      aspectRatio: 16 / 9,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.redAccent,
        handleColor: Colors.redAccent,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white30,
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            'Error al cargar servidor: $errorMessage',
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Buscando Chromecast...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // PANTALLA DEL REPRODUCTOR REAL
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _chewieController != null && _videoPlayerController.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : const Center(child: CircularProgressIndicator(color: Colors.redAccent)),
          ),

          // SELECCIÓN DE SERVIDORES DEBAJO DEL VIDEO
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF0D0E12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(widget.subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 20),

                  const Text('Cambiar Servidor / Calidad (Español):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    value: _selectedServer,
                    dropdownColor: const Color(0xFF1E222D),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF1E222D),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Servidor 1 (Latino HD)', child: Text('Servidor 1 (Latino 1080p - Recomendado)')),
                      DropdownMenuItem(value: 'Servidor 2 (Latino 720p)', child: Text('Servidor 2 (Latino 720p - Ligero/Rápido)')),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedServer = val);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Conectando a: $val...')));
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

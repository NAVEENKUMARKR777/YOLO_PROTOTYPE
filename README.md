# YOLO Need App 🚀

A full-featured, production-ready Flutter application that serves as a role-based, AI-powered community platform for need capture, collaboration, support, and gamified engagement. Now enhanced with a comprehensive **RAG (Retrieval Augmented Generation)** system for intelligent knowledge management and enhanced AI responses.

## 🌟 Features

### 🧠 RAG-Powered AI System
- **Three-Layer RAG Architecture** - Vector Store → AI Foundry → Graph RAG
- **Semantic Search** - Advanced knowledge base search with relevance scoring
- **Knowledge Graphs** - Graph-based reasoning for contextual understanding
- **Structured Answers** - High-quality AI responses with confidence metrics
- **Content Indexing** - Automatic knowledge base updates and maintenance
- **RAG Dashboard** - Comprehensive system monitoring and management

### 🤖 AI-Powered Capabilities
- **Smart Need Categorization** - Uses Azure Vision + Custom Vision for automatic categorization
- **Voice Input** - Natural language need capture with Azure Speech-to-Text
- **Image Analysis** - Automatic object and text detection with Azure Computer Vision
- **Barcode Scanning** - Product identification and categorization
- **Sentiment Analysis** - Analyze emotional tone in user interactions
- **Contextual Search** - Intelligent search using Azure Cognitive Search
- **Enhanced Chat** - RAG-powered AI responses with source citations

### 👥 Role-Based System
- **Seeker** - Post needs and receive help from the community
- **Helper** - Provide assistance and earn rewards
- **Admin** - Manage users, content, and system analytics
- **Business** - Professional service providers

### 🎮 Gamification Engine
- **Points System** - Earn points for contributions and help
- **Badges & Achievements** - Unlock badges for different activities
- **Daily/Weekly Missions** - Complete missions for rewards
- **Leaderboard** - Compete with other community members
- **YOLO Warrior System** - Progressive achievement levels

### 📱 Multi-Platform Support
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

### 🔔 Advanced Notifications
- **Push Notifications** - Real-time updates via Azure Notification Hubs
- **Topic-based Subscriptions** - Need updates, missions, admin broadcasts
- **Quiet Hours** - Customizable notification schedules
- **In-App Notifications** - Rich notification center

### 🛡️ Security & Privacy
- **Azure AD B2C Authentication** - Enterprise-grade security
- **Role-based Access Control** - Granular permissions
- **Data Encryption** - Secure data transmission and storage
- **Privacy Controls** - User control over information sharing

## 🏗️ Architecture

### RAG System Architecture
```
┌─────────────────────────────────────────────────────────┐
│                    UI Layer                            │
│  🎨 RAG Dashboard • Semantic Search • Enhanced Chat   │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│                State Management                        │
│  🔄 Riverpod Providers • RAG System State            │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│              Layer 3: Graph RAG                       │
│  🧠 Context Reasoning • Structured Answer Generation  │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│            Layer 2: Azure AI Foundry                  │
│  🤖 Query Understanding • Contextual Enrichment       │
└─────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────┐
│              Layer 1: Vector Store                    │
│  📊 Vectorization • Semantic Retrieval                │
└─────────────────────────────────────────────────────────┘
```

### Project Structure
```
/lib
├── /screens
│   ├── /auth          # Authentication screens
│   ├── /home          # Dashboard and main screens
│   ├── /need          # Need capture and timeline
│   ├── /chat          # AI and human chat
│   ├── /profile       # User profiles and settings
│   ├── /admin         # Administrative tools
│   ├── /review        # Rating and review system
│   └── /rag           # RAG system dashboard
├── /services/azure    # Azure cloud services integration
│   ├── azure_embeddings.dart      # Vector embeddings
│   ├── azure_vector_database.dart # Vector storage
│   ├── azure_ai_foundry.dart      # Query understanding
│   ├── azure_graph_rag.dart       # Graph reasoning
│   └── azure_ai_chat.dart         # Enhanced chat
├── /models
│   ├── vector_store_model.dart    # Vector store models
│   └── graph_rag_model.dart       # Graph RAG models
├── /providers
│   └── rag_provider.dart          # RAG state management
├── /widgets
│   └── /rag                       # RAG UI components
│       ├── semantic_search_widget.dart
│       ├── rag_chat_widget.dart
│       └── rag_status_widget.dart
└── main.dart         # App entry point
```

### Technology Stack
- **Frontend**: Flutter 3.10+
- **State Management**: Riverpod
- **Navigation**: go_router
- **Backend**: Microsoft Azure
- **Authentication**: Azure AD B2C
- **Database**: Azure Cosmos DB
- **Storage**: Azure Blob Storage
- **AI Services**: Azure OpenAI, Computer Vision, Speech Services
- **RAG System**: Azure OpenAI Embeddings, Vector Math, Graph Processing
- **Notifications**: Azure Notification Hubs

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.10.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- Azure subscription (for cloud services)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/yolo-need-app.git
   cd yolo-need-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Azure Services**
   
   Create the following Azure resources:
   - Azure AD B2C Tenant
   - Azure Cosmos DB
   - Azure Blob Storage
   - Azure Computer Vision
   - Azure Speech Services
   - Azure OpenAI (for RAG system)
   - Azure Notification Hubs

4. **Update Configuration**
   
   Update the Azure service endpoints and keys in the service files:
   - `lib/services/azure/azure_auth.dart`
   - `lib/services/azure/azure_cosmos.dart`
   - `lib/services/azure/azure_blob_storage.dart`
   - `lib/services/azure/azure_vision.dart`
   - `lib/services/azure/azure_speech.dart`
   - `lib/services/azure/azure_embeddings.dart` (RAG)
   - `lib/services/azure/azure_ai_foundry.dart` (RAG)
   - `lib/services/azure/azure_graph_rag.dart` (RAG)
   - `lib/services/azure/azure_notifications.dart`

5. **Run the application**
   ```bash
   flutter run
   ```

## 📱 Core Features

### RAG System Features
- **Semantic Search Widget** - Advanced knowledge base search with filters
- **RAG Chat Widget** - Enhanced AI responses with source citations
- **RAG Status Widget** - System health monitoring and metrics
- **RAG Dashboard** - Comprehensive management interface
- **Content Indexing** - Automatic knowledge base updates
- **Knowledge Graph Management** - Graph-based reasoning system

### Authentication & User Management
- **Multi-factor Authentication** - Phone/email verification
- **Role-based Registration** - Different flows for different user types
- **Profile Management** - Editable user profiles with role-specific fields
- **Session Management** - Secure token handling and refresh

### Need Capture & Management
- **Multi-modal Input** - Text, voice, image, and barcode scanning
- **Smart Categorization** - AI-powered need classification
- **Real-time Updates** - Live status tracking and notifications
- **Timeline View** - Visual progress tracking with milestones

### Community & Collaboration
- **Community Feed** - Trending needs and responses
- **Helper Matching** - AI-powered helper recommendations
- **Chat System** - AI + human hybrid chat support with RAG enhancement
- **Review System** - Comprehensive rating and feedback

### Admin & Analytics
- **User Management** - View, suspend, and manage users
- **Content Moderation** - Review and approve/reject content
- **Analytics Dashboard** - Power BI embedded analytics
- **System Monitoring** - Azure services health and performance
- **RAG System Management** - Knowledge base administration

## 🔧 Configuration

### Azure Services Setup

#### 1. Azure AD B2C
```dart
// Configure in azure_auth.dart
static const String _tenantName = 'your-tenant.b2clogin.com';
static const String _clientId = 'your-client-id';
static const String _redirectUri = 'your-redirect-uri';
```

#### 2. Azure Cosmos DB
```dart
// Configure in azure_cosmos.dart
static const String _endpoint = 'https://your-cosmos-account.documents.azure.com';
static const String _key = 'your-cosmos-key';
static const String _databaseName = 'yolo-need-app';
```

#### 3. Azure Computer Vision
```dart
// Configure in azure_vision.dart
static const String _endpoint = 'https://your-vision-resource.cognitiveservices.azure.com';
static const String _apiKey = 'your-vision-api-key';
```

#### 4. Azure Speech Services
```dart
// Configure in azure_speech.dart
static const String _endpoint = 'https://your-speech-resource.cognitiveservices.azure.com';
static const String _apiKey = 'your-speech-api-key';
```

#### 5. Azure OpenAI (RAG System)
```dart
// Configure in azure_embeddings.dart
static const String _endpoint = 'https://your-openai-resource.openai.azure.com';
static const String _apiKey = 'your-openai-api-key';
static const String _deploymentName = 'text-embedding-ada-002';
```

### Environment Variables
Create a `.env` file in the project root:
```env
AZURE_TENANT_NAME=your-tenant.b2clogin.com
AZURE_CLIENT_ID=your-client-id
AZURE_REDIRECT_URI=your-redirect-uri
AZURE_COSMOS_ENDPOINT=your-cosmos-endpoint
AZURE_COSMOS_KEY=your-cosmos-key
AZURE_VISION_ENDPOINT=your-vision-endpoint
AZURE_VISION_API_KEY=your-vision-api-key
AZURE_SPEECH_ENDPOINT=your-speech-endpoint
AZURE_SPEECH_API_KEY=your-speech-api-key
AZURE_OPENAI_ENDPOINT=your-openai-endpoint
AZURE_OPENAI_API_KEY=your-openai-api-key
AZURE_NOTIFICATION_HUB_NAME=your-notification-hub
```

## 🧠 RAG System Usage

### Accessing the RAG Dashboard
Navigate to the RAG Dashboard to access all RAG system features:
- **Overview Tab** - System status, metrics, and quick actions
- **Search Tab** - Semantic search with advanced filters
- **Chat Tab** - RAG-enhanced chat interface

### Semantic Search
```dart
// Use the semantic search widget
SemanticSearchWidget(
  showFilters: true,
  compactMode: false,
  onResultSelected: () {
    // Handle result selection
  },
)
```

### RAG-Enhanced Chat
```dart
// Use the RAG chat widget
RagChatWidget(
  showRagIndicators: true,
  enableStructuredAnswers: true,
  onSourceSelected: () {
    // Handle source selection
  },
)
```

### System Status Monitoring
```dart
// Monitor RAG system health
RagStatusWidget(
  showDetails: true,
  showQuickActions: true,
)
```

## 📊 Performance & Scalability

### RAG System Performance
- **Vector Search**: Sub-second response times for semantic queries
- **Knowledge Graph**: Efficient graph traversal and reasoning
- **Content Indexing**: Background processing for knowledge updates
- **Memory Management**: Optimized vector storage and retrieval

### Azure Integration
- **Cosmos DB**: Global distribution with multi-region writes
- **Blob Storage**: CDN-enabled content delivery
- **Azure OpenAI**: Scalable AI model inference
- **Notification Hubs**: Real-time push notifications

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Microsoft Azure** for cloud infrastructure and AI services
- **Flutter Team** for the amazing cross-platform framework
- **Riverpod** for state management
- **Community Contributors** for feedback and improvements

## 📞 Support

For support, email support@yolo-need-app.com or join our Discord community.

## 📈 Roadmap

### Version 1.1 (Q3 2025)
- [ ] Advanced AI features
- [ ] Multi-language support
- [ ] Enhanced gamification
- [ ] Performance optimizations

### Version 1.2 (Q3 2025)
- [ ] Offline mode
- [ ] Advanced analytics
- [ ] API integrations
- [ ] Mobile-specific features

### Version 2.0 (Q4 2025)
- [ ] Blockchain integration
- [ ] Advanced security features
- [ ] Enterprise features
- [ ] White-label solution

---

**Made with ❤️ by the YOLO Need App Team**

*Empowering communities through AI-powered need matching and gamified engagement.*

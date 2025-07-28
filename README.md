# Mobile_App_Journey
Dart and Flutter study and app development

# GES Lesson Note Generator

A Flutter mobile application designed to help Ghanaian teachers generate professional lesson notes based on the Ghana Education Service (GES) curriculum for basic schools (KG to JHS).

## Features

### 🎯 Core Functionality
- **AI-Powered Generation**: Generate detailed lesson notes using advanced AI technology
- **GES Curriculum Compliant**: Follows official Ghana Education Service format and standards
- **Multi-Level Support**: Covers KG 1 to JHS 3 across all major subjects
- **Professional Formatting**: Includes all required sections per GES guidelines

### 📱 User Experience
- **Intuitive Interface**: Clean, Ghana-themed design with easy navigation
- **Voice Input**: Speech-to-text functionality for accessibility and convenience
- **Edit & Preview**: Review and modify generated content before saving
- **Form Validation**: Ensures all required fields are completed correctly

### 💾 Storage & Export
- **Local Storage**: Save lesson notes and templates on device
- **PDF Export**: Generate professional PDF documents for printing
- **Share Options**: Share lesson notes via email, messaging, or other apps
- **Copy to Clipboard**: Quick copying for use in other applications

### 🎨 Design
- **Ghana-Inspired Theme**: Colors reflecting the Ghanaian flag (green, yellow, red)
- **Responsive Design**: Works seamlessly on different screen sizes
- **Dark Mode Support**: Automatic theme switching based on system preferences
- **Accessibility**: Voice input and screen reader support

## Screenshots

```
[Add screenshots of your app here]
- Home screen with form inputs
- Voice input in action
- Lesson note preview screen
- PDF export functionality
```

## Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- OpenAI API key (for AI generation)

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/ges-lesson-note-generator.git
   cd ges-lesson-note-generator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
   - Open `lib/services/lesson_note_service.dart`
   - Replace `YOUR_OPENAI_API_KEY` with your actual OpenAI API key
   ```dart
   static const String _apiKey = 'your-actual-api-key-here';
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Android Permissions
The app requires the following permissions:
- **INTERNET**: For AI API calls
- **RECORD_AUDIO**: For voice input functionality
- **WRITE_EXTERNAL_STORAGE**: For PDF export
- **READ_EXTERNAL_STORAGE**: For file access

## Usage Guide

### Generating a Lesson Note

1. **Select Class Level**: Choose from KG 1 to JHS 3
2. **Choose Subject**: Pick from available GES curriculum subjects
3. **Enter Topic**: Type or use voice input to specify the lesson topic
4. **Set Date**: Select the lesson date using the date picker
5. **Generate**: Tap the "Generate Lesson Note" button

### Editing and Saving

1. **Review**: Check the generated content in preview mode
2. **Edit**: Switch to edit mode to modify any sections
3. **Save**: Use the save option to store locally
4. **Export**: Generate PDF or share via other apps

### Voice Input

1. **Tap the microphone icon** next to the topic field
2. **Grant permission** when prompted
3. **Speak clearly** - the app will convert speech to text
4. **Review and edit** the transcribed text if needed

## GES Lesson Note Format

The app generates lesson notes with all required GES sections:

1. **Week and Date**
2. **Class**
3. **Subject**
4. **Topic**
5. **Sub-topic** (if applicable)
6. **Duration**
7. **Strand** (if applicable)
8. **Indicators/Objectives**
9. **Core Competencies**
10. **Learning Materials**
11. **Introduction**
12. **Main Activities** (step-by-step with TLM usage)
13. **Assessment**
14. **Summary/Conclusion**
15. **Pupils' Exercise** (short)
16. **Homework**

## Supported Subjects

- English Language
- Mathematics
- Science
- Social Studies
- Religious and Moral Education
- Ghanaian Language
- French
- Creative Arts
- Physical Education
- ICT

## Technical Architecture

### Dependencies
- **http**: API communication
- **shared_preferences**: Local data storage
- **speech_to_text**: Voice input functionality
- **permission_handler**: Runtime permissions
- **pdf**: PDF document generation
- **printing**: PDF preview and printing
- **share_plus**: Content sharing

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── models/
│   └── lesson_note_data.dart # Data models
├── screens/
│   ├── home_screen.dart      # Main input form
│   └── lesson_note_preview_screen.dart # Preview/edit screen
├── services/
│   ├── lesson_note_service.dart # AI API integration
│   └── storage_service.dart     # Local storage
├── widgets/
│   └── voice_input_button.dart # Voice input component
└── theme/
    └── app_theme.dart        # App styling
```

## Contributing

We welcome contributions to improve the GES Lesson Note Generator! Here's how you can help:

### Getting Started
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Areas for Contribution
- **Subject-specific templates**: Add specialized templates for different subjects
- **Offline functionality**: Implement local AI models for offline use
- **Cloud sync**: Add Firebase or Supabase integration
- **UI improvements**: Enhance the user interface and experience
- **Localization**: Add support for local Ghanaian languages
- **Testing**: Improve test coverage

### Code Style
- Follow Dart/Flutter conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Ensure proper error handling

## Roadmap

### Version 1.1 (Planned)
- [ ] Lesson note templates for different subjects
- [ ] Weekly/monthly lesson planning
- [ ] Improved PDF formatting
- [ ] Backup and restore functionality

### Version 1.2 (Future)
- [ ] Cloud synchronization
- [ ] Collaborative features for teachers
- [ ] Offline AI integration
- [ ] Advanced customization options

### Version 2.0 (Long-term)
- [ ] Web application version
- [ ] School administration features
- [ ] Student progress tracking
- [ ] Integration with school management systems

## Troubleshooting

### Common Issues

**Voice input not working**
- Ensure microphone permission is granted
- Check device microphone functionality
- Try restarting the app

**PDF export fails**
- Verify storage permissions
- Check available device storage
- Ensure stable internet connection

**API errors**
- Verify OpenAI API key is correct
- Check internet connectivity
- Monitor API usage limits

**App crashes on startup**
- Clear app data and cache
- Reinstall the application
- Check device compatibility

## Support

### Getting Help
- **Issues**: Report bugs on GitHub Issues
- **Discussions**: Join community discussions
- **Email**: Contact support at [your-email@example.com]
- **Documentation**: Check the wiki for detailed guides

### FAQ

**Q: Is this app free to use?**
A: Yes, the app is free. However, you need your own OpenAI API key for AI generation.

**Q: Does it work offline?**
A: Currently, internet connection is required for AI generation. Offline functionality is planned for future versions.

**Q: Can I customize the lesson note format?**
A: The current version follows standard GES format. Customization options are planned for future releases.

**Q: Is my data secure?**
A: All data is stored locally on your device. API calls are made securely to OpenAI servers.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **Ghana Education Service** for curriculum guidelines
- **Flutter Team** for the amazing framework
- **OpenAI** for AI capabilities
- **Ghanaian Teachers** for feedback and requirements
- **Open Source Community** for various packages used

## Contact

**Developer**: [Maxwell Ahorlu]
**Email**: [Quammy93@gmail.com]
**GitHub**: [https://github.com/Quammy93](https://github.com/Quammy93)
**LinkedIn**: [Your LinkedIn Profile]

---

**Made with ❤️ for Ghanaian Teachers**

*Empowering education through technology*
```

This comprehensive README file includes:

1. **Clear project description** and purpose
2. **Detailed feature list** with emojis for visual appeal
3. **Step-by-step installation** instructions
4. **Usage guide** for all major features
5. **Technical documentation** including architecture and dependencies
6. **Contributing guidelines** to encourage community involvement
7. **Roadmap** showing future development plans
8. **Troubleshooting section** for common issues
9. **Support information** and FAQ
10. **Professional formatting** with proper markdown syntax

The README is structured to help both users and developers understand the project quickly and get started with either using or contributing to the application.
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';
import 'package:ice_shield/data_layer/DataSources/local_database/Database.dart';

class TextEditorPage extends StatefulWidget {
  final ProjectNoteData? note;

  const TextEditorPage({super.key, this.note});

  @override
  State<TextEditorPage> createState() => _TextEditorPageState();
}

class _TextEditorPageState extends State<TextEditorPage> {
  late final QuillController _controller;
  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');

    if (widget.note != null) {
      try {
        final json = jsonDecode(widget.note!.content);
        _controller = QuillController(
          document: Document.fromJson(json),
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        print('Error parsing note content: $e');
        _controller = QuillController.basic();
      }
    } else {
      _controller = QuillController.basic();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final title = _titleController.text;
    final content = jsonEncode(_controller.document.toDelta().toJson());

    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a title')));
      return;
    }

    try {
      if (widget.note != null) {
        await context.read<ProjectNoteDAO>().updateNote(
          widget.note!.copyWith(title: title, content: content),
        );
      } else {
        await context.read<ProjectNoteDAO>().insertNote(
          title: title,
          content: content,
        );
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Note saved successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving note: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      extendBodyBehindAppBar: true, // Allow body to go behind the custom header
      body: Stack(
        children: [
          // Background gradient (optional, subtle touch)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.surface,
                    colorScheme.surfaceContainerHighest.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),

          Column(
            children: [
              // Custom Header
              _buildCustomHeader(context, colorScheme),

              // Editor Area
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      // Title Input with Hero
                      Hero(
                        tag: 'note_title_${widget.note?.noteID ?? "new"}',
                        child: Material(
                          color: Colors.transparent,
                          child: TextField(
                            controller: _titleController,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: colorScheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Untitled',
                              hintStyle: TextStyle(
                                color: colorScheme.onSurface.withOpacity(0.3),
                                fontWeight: FontWeight.w800,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Editor
                      Expanded(
                        child: QuillEditor.basic(
                          controller: _controller,
                          config: QuillEditorConfig(
                            placeholder: 'Start typing your amazing ideas...',
                            padding: const EdgeInsets.only(
                              bottom: 100,
                            ), // Space for floating toolbar
                            // locale: Locale('en'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Floating Toolbar
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withOpacity(
                        0.6,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.outline.withOpacity(0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: QuillSimpleToolbar(
                      controller: _controller,
                      config: const QuillSimpleToolbarConfig(
                        showFontFamily: false,
                        showFontSize: false,
                        showSearchButton: false,
                        showSubscript: false,
                        showSuperscript: false,
                        toolbarIconAlignment: WrapAlignment.center,
                        buttonOptions: QuillSimpleToolbarButtonOptions(
                          base: QuillToolbarBaseButtonOptions(
                            iconTheme: QuillIconTheme(
                              iconButtonSelectedData: IconButtonData(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.white24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context, ColorScheme colorScheme) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: colorScheme.onSurface,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainerHighest
                    .withOpacity(0.5),
                padding: const EdgeInsets.all(12),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.save_outlined, color: colorScheme.primary),
                  onPressed: _saveNote,
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.primaryContainer.withOpacity(
                      0.5,
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.more_horiz, color: colorScheme.onSurface),
                  onPressed: () {
                    // TODO: Implement more options
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.surfaceContainerHighest
                        .withOpacity(0.5),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:live_search/mixin/comparator_manager.dart';
import 'package:live_search/rounded_container/custom_rounded_container.dart';
import 'package:live_search/text_field/app_search_text_field.dart';

class SearchBottomSheet extends HookWidget with ComparatorManager {
  const SearchBottomSheet({
    super.key,
    this.label,
    this.additionLabel,
    required this.hint,
    this.value,
    this.errorNotifier,
    required this.bottomSheetLabel,
    required this.list,
    required this.onChanged,
    this.additionLabelStyle,
    this.labelStyle,
    required this.backGroundColor,
    this.locationStyle,
    required this.borderColor,
    this.barrierColor,
    this.bottomSheetBackgroundColor,
    this.bottomSheetLabelStyle,
    this.itemStyle,
    this.highlightStyle,
    this.checkIcon,
    this.prefixIcon,
  });

  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? locationStyle;
  final String? additionLabel;
  final TextStyle? additionLabelStyle;
  final TextStyle? itemStyle;
  final TextStyle? highlightStyle;
  final String hint;
  final String bottomSheetLabel;
  final TextStyle? bottomSheetLabelStyle;
  final String? value;
  final ValueNotifier<String>? errorNotifier;
  final List<String> list;
  final void Function(String value) onChanged;
  final Color backGroundColor;
  final Color borderColor;
  final Color? barrierColor;
  final Color? bottomSheetBackgroundColor;
  final Widget? checkIcon;
  final Widget? prefixIcon;

  @override
  build(context) {
    final locationNotifier = useValueNotifier<String>('');
    final locListNotifier = useValueNotifier(list);
    final textController = useTextEditingController();

    useEffect(
      () {
        locationNotifier.value = value ?? '';
        return null;
      },
      [value],
    );

    useEffect(
      () {
        locListNotifier.value = list;

        textController.addListener(() {
          final input = textController.text;

          locListNotifier.value = sortByCharacters(
                locList: locListNotifier.value,
                input: input,
              ) ??
              list;
        });

        return null;
      },
      [list],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
              text: label!,
              style: labelStyle,
              children: [
                if (additionLabel?.isNotEmpty == true)
                  TextSpan(
                    text: additionLabel!,
                    style: additionLabelStyle,
                  ),
              ],
            ),
          ),
        HookBuilder(builder: (_) {
          final location = useValueListenable(locationNotifier);

          return CustomRoundedContainer(
              onTap: () => showBottomSheet(context, locListNotifier, textController),
              backGround: location.isEmpty ? Colors.transparent : backGroundColor,
              boxBorder: location.isEmpty ? Border.all(color: borderColor) : null,
              margin: EdgeInsets.only(top: label != null ? 8 : 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    location.isEmpty ? hint : location,
                    style: locationStyle,
                  ),
                  if (prefixIcon != null) prefixIcon!
                ],
              ));
        }),
        if (errorNotifier != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder<String>(
              valueListenable: errorNotifier!,
              builder: (_, error, __) => error.isNotEmpty
                  ? Text(
                      error,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    )
                  : const SizedBox(),
            ),
          ),
      ],
    );
  }

  void showBottomSheet(
    BuildContext context,
    ValueNotifier<List<String>> locListNotifier,
    TextEditingController textController,
  ) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        barrierColor: barrierColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
        ),
        builder: (modalContext) {
          return FractionallySizedBox(
            heightFactor: .8,
            child: DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: .6,
              maxChildSize: 1,
              builder: (_, scrollController) => CustomRoundedContainer(
                showSplash: false,
                backGround: bottomSheetBackgroundColor ?? Colors.transparent,
                borderRadiusGeometry: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: HookBuilder(builder: (_) {
                  final locList = useValueListenable(locListNotifier);
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    scrollController.jumpTo(1);
                  });

                  return Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      const NonClickableCustomRoundedContainer(
                        width: null,
                        backGround: Colors.grey,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        child: SizedBox(
                          height: 4,
                          width: 76,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        bottomSheetLabel,
                        style: bottomSheetLabelStyle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppSearchTextField(
                        controller: textController,
                        boxFit: BoxFit.cover,
                      ),
                      Expanded(
                        child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            itemCount: locList.length,
                            itemBuilder: (_, i) {
                              final item = locList[i];

                              return CustomRoundedContainer(
                                  key: ValueKey(item),
                                  onTap: () {
                                    onChanged(item);
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    Navigator.of(modalContext).pop();
                                  },
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  radius: 16,
                                  backGround: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: highlightOccurrences(item, textController.text),
                                          style: itemStyle,
                                        ),
                                      ),
                                      if (value == item && checkIcon != null) checkIcon!
                                    ],
                                  ));
                            }),
                      )
                    ],
                  );
                }),
              ),
            ),
          );
        });
  }

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty) {
      return [TextSpan(text: source)];
    }

    final List<TextSpan> spans = [];
    int start = 0;
    int index;

    while ((index = source.toLowerCase().indexOf(query.toLowerCase(), start)) != -1) {
      if (index > start) {
        spans.add(TextSpan(text: source.substring(start, index)));
      }

      spans.add(TextSpan(
        text: source.substring(index, index + query.length),
        style: highlightStyle,
      ));

      start = index + query.length;
    }

    if (start < source.length) {
      spans.add(TextSpan(text: source.substring(start)));
    }

    return spans;
  }
}

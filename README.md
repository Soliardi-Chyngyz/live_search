# live_search

Используйте SearchBottomSheet только внутри родительского виджеты HookWidget
также доступны виджеты:

CustomRoundedContainer
NonClickableCustomRoundedContainer

```Dart
SearchBottomSheet(
    value: _selectedItem,
    additionLabel: ' *',
    label: 'Область торговой точки',
    hint: 'Выберите область',
    bottomSheetLabel: 'Выберите область',
    list: yourList,
    onChanged: (String onSelectedItem) {

        setState(() {
        _selectedItem = onSelectedItem });
        });
```

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

Чтобы стянуть либу вбейте этот текст в bubspec.yaml и введите команду **flutter pub get**
```
dependencies:
  live_search:
    git: https://github.com/Soliardi-Chyngyz/live_search.git 

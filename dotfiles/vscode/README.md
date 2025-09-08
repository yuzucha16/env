```shell
Get-Content C:\Users\kz\vault\dev\src\github.com\yuzucha16\env\dotfiles\vscode\extensions.txt | ForEach-Object { code --install-extension $_ }
```



```powershell
Get-Content .\extensions.txt | ForEach-Object { code --install-extension $_ }

```

```bash
xargs -r -n1 code --install-extension < extensions.txt
```


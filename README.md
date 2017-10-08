# Shared flat template

This is a shared flat agreement template. You can set
variables in `variables`.  To build, you need [gpp][1] and
[pandoc][2]. Run the following command:

``` shell
$ gpp --include variables -H contract.md | pandoc -o contract.pdf
```

[1]: https://logological.org/gpp
[2]: https://pandoc.org/

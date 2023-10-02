# OverTheWire Bandit12 Solution

This markdown guides you through solving the Bandit12 challenge from OverTheWire using a simplified approach.

## Objective:

Decompress the repeatedly compressed file `data.txt` to obtain the password for the next level.

## Instructions:

1. **Setting Up the Working Directory**:
   Create a temporary directory to work within:

   ```bash
   mkdir /tmp/temp_dir
   cd /tmp/temp_dir
   ```

2. **Creating and Setting Up the Decompression Script**:
   Create a script named `xtractor.sh` which will handle the decompression:

   Using `vim`:

   ```bash
   vim xtractor.sh
   ```

   Or, if you prefer `nano`:

   ```bash
   nano xtractor.sh
   ```

   Once inside your chosen editor, paste the following content:

```bash
#!/bin/bash
dir=$(basename $PWD)
cp /home/bandit12/data.txt /tmp/$dir/backup
xxd -r backup >data

ftype=$(file -b --mime-type data* | cut -d '/' -f2)

until [ $ftype == 'plain' ]; do
        case $ftype in
        gzip)
                mv data* data.gz
                gzip -d data.gz
                echo "gzip -> data"
                ;;

        x-bzip2)
                mv data* data.bz2
                bzip2 -d data.bz2
                echo "bzip2 -> data"
                ;;

        x-tar)
                if [ $(ls | grep "bin") ]; then
                        bfile=$(ls | grep *"bin")
                        tar -xf $bfile
                        rm $bfile
                else
                        tar -xf data
                        rm data
                fi
                echo "tar -> data"
                ;;
        esac
        ftype=$(file -b --mime-type data* | cut -d '/' -f2)
done

cat data
```

Save and exit the editor. (`Esc` followed by `:wq` for vim, or `Ctrl + O` followed by `Ctrl + X` for nano).

3. **Making the Script Executable**:

   ```bash
   chmod u+x xtractor.sh
   ```

4. **Executing the Decompression Script**:
   Simply run the script to see the password for the next level:

   ```bash
   ./xtractor.sh
   ```

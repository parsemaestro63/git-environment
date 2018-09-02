#!/bin/bash

function createAliasesIfNotExists {
	OS=$(uname)
	CREATED=false

	if [[ $OS == "Linux" ]]; then
		ALIAS_FILE=".bash_aliases"

		if [ ! -f $HOME/.bash_aliases ]; then
			createAliasesFile
		fi
	elif [[ $OS == "Darwin" ]]; then
		ALIAS_FILE=".bash_profile"

		if [ ! -f $HOME/.bash_profile ]; then
			createAliasesFile
		fi
	else
		echo "The OS doesn't appear to be one of MacOS or Ubuntu"
		exit 1
	fi
}

function createAliasesFile {
	cp aliases.sh $HOME/$ALIAS_FILE
	source $HOME/$ALIAS_FILE
	CREATED=true

}

function replaceAliases {
	while read LINE; do
		MATCH=0
		ALIAS=$LINE;

		if [[ $(echo $ALIAS | cut -d " " -f1) == alias ]]; then
			PARTS=$(echo $ALIAS | sed -e 's/alias\(.*\)=/\1=/')
			KEY=$(echo $PARTS | cut -d = -f 1)
			COMMAND=$(echo $PARTS | cut -d = -f 2)

			while read LINE; do
				STATEMENT=$LINE

				if [[ $(echo $STATEMENT | cut -d " " -f1) == alias ]]; then
					FILE_SPLIT=$(echo $STATEMENT | sed -e 's/alias\(.*\)=/\1=/')
					FILE_ALIAS=$(echo $FILE_SPLIT | cut -d = -f 1)

					if [[ "$FILE_ALIAS" == "$KEY" ]]; then
						MATCH=1
					fi
				fi
			done < $HOME/$ALIAS_FILE

			if [[ $MATCH == 0 ]]; then
				echo alias ${KEY}=${COMMAND} >> $HOME/$ALIAS_FILE
			fi
		fi;
	done < aliases.sh
}

createAliasesIfNotExists

# If aliases already exist, then determine existing aliases and create Git aliases that don't exist
if [[ $CREATED == "false" ]]; then
	replaceAliases
	source $HOME/$ALIAS_FILE;
fi
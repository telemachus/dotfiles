# port installed requested | tail -n +2 | awk -f port.awk
{
	if (match($2, /\+/)) {
		variants = substr($2, RSTART)
		gsub(/\+/, " +", variants)
		print $1, variants
	} else {
		print $1
	}
}

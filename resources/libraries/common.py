"""A library for custom keywords
"""
import json
import re


def fill_variables_from_text_string(*args):
	# the multi-line variable in a table form is splitted, keys are the 0 element and values are the 1st element.
	#Both are just strings with | separators
    arguments = ' '.join(args)
    keys = (arguments.split(' || '))[0]
    values = (arguments.split(' || '))[1]
    # now the strings are splitted by "|" separator. Also strip() removes all whitespaces
    keys_list = (keys.split('|'))
    values_list = (values.split('|'))
    dictionatry = dict()
    for item in keys_list:
        # 'if item' checks if the key value is not empty and iterates only over keys that have a value
        if item:
    	    # interate through all keys, get their indexes and assign to each a value with the same index and put them into disctionary
            # strip() removed all whitespaces
            key = item.strip()
            index = keys_list.index(item)
            value = values_list[index].strip()
            dictionatry[key] = value
    return dictionatry

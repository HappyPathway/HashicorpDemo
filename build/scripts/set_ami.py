#!/usr/bin/env python2.7
import os

def script_path():
    return os.path.dirname(os.path.abspath(__file__))

def main(opt):
    # services/staging/app/
    key = os.path.join("services", opt.service)
    key = os.path.join(key, opt.version)
    key = os.path.join(key, "ami")
    cmd = "python2.7 {0}/consul_import.py --key={1} --value={2}"
    os.system(cmd.format(script_path(), key, opt.ami))

if __name__ == '__main__':
    from optparse import OptionParser
    parser = OptionParser()
    parser.add_option('--service')
    parser.add_option('--version')
    parser.add_option('--ami')
    opt, arg = parser.parse_args()
    main(opt)
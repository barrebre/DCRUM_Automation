dcrum_automation Cookbook
====================
This cookbook is used to deploy the Windows DC RUM platform.

Usage
-----
'dcrum_automation' has three flavors:

1. Master CAS - Include all cookbooks in your node's 'run_list' in the following order:
  1. default
  2. css_install
  3. rum_install
  4. cas_install
  5. ads_install

2. Slave CAS or ADS - Include the following cookbooks in your node's 'run_list' in the following order:
  1. default
  2. cas_install or ads_install

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `[username]_add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Created by <a href="mailto:brett.barrett@dynatrace.com?subject=DC%20RUM%20Automation">Brett Barrett</a>

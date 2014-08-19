public with sharing class UtilityClass 
{
	public List<Integer> sortIntegers(List<Integer> listIntegers)
	{
		for (Integer i = 0; i < (listIntegers.size() - 1); i++)
		{
		    for (Integer j = (i + 1); j < listIntegers.size(); j++) 
		    {
		        if (listIntegers[i] > listIntegers[j])
		        {
		            Integer temp = listIntegers[i];
		            listIntegers[i] = listIntegers[j];
		            listIntegers[j] = temp;
		        }
		    }
		}
		return listIntegers;
	} 
	/*
	UtilityClass u = new UtilityClass();
	List<Integer> listInt = new List<Integer>();
	listInt.add(3);
	listInt.add(1);
	listInt.add(2);
	listInt.add(8);
	listInt.add(4);
	
	system.debug(u.sortIntegers(listInt));
	*/
}
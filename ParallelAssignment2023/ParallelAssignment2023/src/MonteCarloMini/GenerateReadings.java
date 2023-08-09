package MonteCarloMini;

import java.util.ArrayList;
import MonteCarloMini.MonteCarloMinimization;
import MonteCarloMini.MonteCarloMinimizationParallel;
import java.io.FileWriter;
import java.io.IOException;

public class GenerateReadings {

    public static void main(String[] args)
    {
        String[][] varyingSearches = 
        {
            {"100","100","-10","10","-50","50","1"},
             {"250","250","-10","10","-50","50","1"},
              {"500","500","-10","10","-50","50","1"},
               {"750","750","-10","10","-50","50","1"},
                {"1000","1000","-10","10","-50","50","1"},
                 {"1250","1250","-10","10","-50","50","1"},
                  {"1500","1500","-10","10","-50","50","1"},
                   {"2000","2000","-10","10","-50","50","1"},
                    {"2500","2500","-10","10","-50","50","1"},
                     {"3000","3000","-10","10","-50","50","1"},
                      {"3500","3500","-10","10","-50","50","1"},
                       {"4000","4000","-10","10","-50","50","1"},
                        {"4500","4500","-10","10","-50","50","1"},
                         {"5000","5000","-10","10","-50","50","1"},
                          {"5500","5500","-10","10","-50","50","1"},
                           {"6000","6000","-10","10","-50","50","1"},
                           {"100","100","-10","10","-50","50","0.7"},
             {"250","250","-10","10","-50","50","0.7"},
              {"500","500","-10","10","-50","50","0.7"},
               {"750","750","-10","10","-50","50","0.7"},
                {"1000","1000","-10","10","-50","50","0.7"},
                 {"1250","1250","-10","10","-50","50","0.7"},
                  {"1500","1500","-10","10","-50","50","0.7"},
                   {"2000","2000","-10","10","-50","50","0.7"},
                    {"2500","2500","-10","10","-50","50","0.7"},
                     {"3000","3000","-10","10","-50","50","0.7"},
                      {"3500","3500","-10","10","-50","50","0.7"},
                       {"4000","4000","-10","10","-50","50","0.7"},
                        {"4500","4500","-10","10","-50","50","0.7"},
                         {"5000","5000","-10","10","-50","50","0.7"},
                          {"5500","5500","-10","10","-50","50","0.7"},
                           {"6000","6000","-10","10","-50","50","0.7"},
                           {"100","100","-10","10","-50","50","0.4"},
             {"250","250","-10","10","-50","50","0.4"},
              {"500","500","-10","10","-50","50","0.4"},
               {"750","750","-10","10","-50","50","0.4"},
                {"1000","1000","-10","10","-50","50","0.4"},
                 {"1250","1250","-10","10","-50","50","0.4"},
                  {"1500","1500","-10","10","-50","50","0.4"},
                   {"2000","2000","-10","10","-50","50","0.4"},
                    {"2500","2500","-10","10","-50","50","0.4"},
                     {"3000","3000","-10","10","-50","50","0.4"},
                      {"3500","3500","-10","10","-50","50","0.4"},
                       {"4000","4000","-10","10","-50","50","0.4"},
                        {"4500","4500","-10","10","-50","50","0.4"},
                         {"5000","5000","-10","10","-50","50","0.4"},
                          {"5500","5500","-10","10","-50","50","0.4"},
                           {"6000","6000","-10","10","-50","50","0.4"}

            
        };

        try{
            FileWriter fileWriterSerial1 = new FileWriter("data/varyingSearchesSerial.txt");
            fileWriterSerial1.write("searches_density num_searches time min\n");
            fileWriterSerial1.close();

            FileWriter fileWriterParallel1 = new FileWriter("data/varyingSearchesParallel.txt");
            fileWriterParallel1.write("searches_density num_searches time min\n");
            fileWriterParallel1.close();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }

        // Serial points
         System.out.println("Serial points");
        for (int c = 0; c<47; c++) // 6000 x 6000 crashes
        {
            System.out.println("On grid size of: " + varyingSearches[c][0] + "x" + varyingSearches[c][0]);
            for (int j = 0; j < 5; j++)
            {
                MonteCarloMinimization.main(varyingSearches[c]);
            }
        }

        // Parallel points
        System.out.println("Parallel points");
        for (int i = 0; i <47; i++)
        {
            System.out.println("On grid size of: " + varyingSearches[i][0] + "x" + varyingSearches[i][0]);
            for (int j = 0; j < 5; j++)
            {
                MonteCarloMinimizationParallel.main(varyingSearches[i]);
            }
        }
    }
}

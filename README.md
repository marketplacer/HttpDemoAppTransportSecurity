#  A demo iOS app that shows an error loading data from https service.

This demo app loads data from this url: https://www.bikeexchange.com.au/

Request fails with the following error:

> NSURLSession/NSURLConnection HTTP load failed (kCFStreamErrorDomainSSL, -9802)

The problem can be fixed by disabling "forward secrecy" requirement NSExceptionRequiresForwardSecrecy in the Info.plist:


```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSExceptionDomains</key>
  <dict>
      <key>bikeexchange.com.au</key>
      <dict>
          <key>NSIncludesSubdomains</key>
          <true/>
          <key>NSExceptionRequiresForwardSecrecy</key>
          <false/>
      </dict>
  </dict>
</dict>
```

## What is wrong with the request?

I would like to know what exactly was wrong with the https://www.bikeexchange.com.au/ request.
According to [ssllabs.com analysis](https://www.ssllabs.com/ssltest/analyze.html?d=bikeexchange.com.au) the server **does support forward secrecy**.

<img src='https://raw.githubusercontent.com/exchangegroup/HttpDemoAppTransportSecurity/master/graphics/ssllabs_bikeexchange.png' width='576' alt='SSL forward secrecy report'>


The problem with the server **can be** that the it uses weak ciphers, but it would be nice to know exactly which ciphers are causing the problem so they can be removed.

See the list of supported ciphers in the apple documentation: https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/